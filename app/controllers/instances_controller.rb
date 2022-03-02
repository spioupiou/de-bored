class InstancesController < ApplicationController
  require 'custom_classes/passcode' # this is from lib/custom_classes

  skip_before_action :authenticate_user!

  def create
    # check last_instance_id from views/rounds/show.html.erb is there
    if params[:last_instance_id].nil?
      # this block means the host is creating an instance from games list

      @instance = generate_new_instance_from_scratch
      # host must also be created as a player
      Player.create!(
        user_id: current_or_guest_user.id,
        instance_id: @instance.id
      )
    else
      # this block means the host is creating an instance based from previous instance

      # check if last_instance_id is there from views/rounds/show.html.erb
      last_instance = Instance.find(params[:last_instance_id])
      # cause last round has been completed
      last_instance.update(status: "done") if last_instance.status == "ongoing"

      @instance = generate_new_instance_from_last(last_instance)
      # also includes creation of host as a player
      create_players_from_previous_instance(last_instance, @instance)

      # get the final round of the last_instance, users from that action cable needs to be redirected
      # `first` is needed to take the object out of the array caused by using `where`
      prev_instance_final_round = Round.where(instance: last_instance).order(id: :desc).limit(1).first
      # redirect players to instance show page, this does not include host
      RoundChannel.broadcast_to(
        prev_instance_final_round,
        head: 303, # redirection code
        path: instance_path(@instance)
      )
    end

    # redirect host to instance show page
    redirect_to instance_path(@instance)
  end

  def show
    # Display the game instance with users subscribed (web socket)
    @instance = Instance.find(params[:id])
    @game = Game.find(@instance.game_id)
    @players = Player.where(instance_id: @instance.id)
    @current_user = current_or_guest_user

    # QR Code rendering
    @qr_code = RQRCode::QRCode.new(@instance.qr_code)
    @svg = @qr_code.as_svg(
      offset: 0,
      color: '000',
      shape_rendering: 'crispEdges',
      standalone: true,
      module_size: 5
    )

    # To grab the list of players' names in the instance (Also includes the host name...)
    player_ids = @players.map(&:user_id)
    @each_player_id = player_ids.join(', ')
    @each_player_name = player_ids.map { |id| User.find(id).nickname }.join(', ')
  end

  def update # Update the settings of the instance
    @instance = Instance.find(params[:id])

    if @instance.update(instance_params)
      InstanceChannel.broadcast_to(
        @instance,
        {
          game_settings: true,
          page:
              render_to_string( partial: "/instances/show_game_settings",
              locals: { instance: @instance }),
          count:
              render_to_string( partial: "/instances/max_player_count", locals: { instance: @instance })
        })
      redirect_to instance_path(@instance), notice: "Game Settings Updated"
    end
  end

  private

  def instance_params
    params.require(:instance).permit(:max_players, :max_rounds, :passcode)
  end

  def generate_new_instance_from_scratch
    # Create an instance with current_user as host
    # defaults - status: "waiting", max_rounds: 5
    instance = Instance.new(
      game_id: params[:game_id],
      user_id: current_or_guest_user.id
    )

    # returns the instance after it got saved with a unique passcode
    assign_passcode(instance)
    assign_qrcode(instance)
  end

  def generate_new_instance_from_last(last_instance)
    # Create an instance based from the last instance
    # Defaults - status: "waiting", rounds must be inherited
    instance = Instance.new(
      game: last_instance.game,
      user: last_instance.user,
      max_players: last_instance.max_players,
      max_rounds: last_instance.max_rounds
    )
    # returns the instance after it got saved with a uinuqe passcode
    assign_passcode(instance)
    assign_qrcode(instance)
  end

  def assign_passcode(instance)
    passcode_array = Passcode.passcodes
    # loop until a unique passcode (scope -> instanes with 'waiting' status) is generated for the instance
    loop do
      passcode_array = Passcode.passcodes if passcode_array.empty?
      # shuffle array and pop one out
      # popping reduces the chance of re-using the same passcode again and again
      instance.passcode = passcode_array.shuffle!.pop
      break if instance.save
    end

    instance
  end

  def assign_qrcode(instance)
    # QR Code will redirect to Instance#Show page with the passcode passed as a param
    instance.qr_code = join_instance_url(passcode: instance.passcode)
    instance.save
    instance
  end

  def create_players_from_previous_instance(last_instance, new_instance)
    user_ids = Player.where(instance: last_instance).map(&:user_id)

    user_ids.each do |user_id|
      Player.create!(
        user_id: user_id,
        instance: new_instance
      )
    end
  end
end
