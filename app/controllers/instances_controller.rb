class InstancesController < ApplicationController
  require 'custom_classes/passcode' # this is from lib/custom_classes

  skip_before_action :authenticate_user!

  def create
    # Create an instance with current_user as host, instance default status is "waiting"
    @instance = Instance.new(
      game_id: params[:game_id],
      user_id: current_or_guest_user.id,
      max_rounds: 5
    )

    # loop until a unique passcode (scope -> instanes with 'waiting' status) is generated for the instance
    loop do
      @instance.passcode = Passcode.generate_passcode
      break if @instance.save
    end
    
    # Make the host a player
    Player.create!(
      user_id: current_or_guest_user.id,
      instance_id: @instance.id
    )

    # skip the if block when concatenated_user_ids is nil or empty string
    if params[:concatenated_user_ids]
      user_ids = params[:concatenated_user_ids].split.map(&:to_i)

      # create each user as a player in the new instance
      user_ids.each do |user_id|
        Player.create!(
          user_id: user_id,
          instance_id: @instance.id
        )
      end

      RoundChannel.broadcast_to(
        Round.find(params[:round_id]),
        head: 303, # redirection code
        path: instance_path(@instance)
      )
    end

    # Redirect to instance show page
    redirect_to instance_path(@instance)
  end

  def show # Display the game instance with users subscribed (web socket)
    @instance = Instance.find(params[:id])
    @game = Game.find(@instance.game_id)
    @host = User.find(@instance.user_id)
    @players = Player.where(instance_id: @instance.id)
    @current_user = current_or_guest_user

    # To grab the list of players' names in the instance (Also includes the host name...)
    @player_ids = @players.map(&:user_id)
    @each_player_id = @player_ids.join(', ')
    @each_player_name = @player_ids.map { |id| User.find(id).nickname }.join(', ')
  end

  def update # Update the status, pending -> ongoing -> completed
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
    params.require(:instance).permit(:max_players, :max_rounds, :pin)
  end
end
