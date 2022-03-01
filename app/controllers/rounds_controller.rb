class RoundsController < ApplicationController
  skip_before_action :authenticate_user!

  # Start creating a round after Start button or Next Question button has been clicked
  def create
    begin
      current_round_id = params[:current_round].to_i
      current_round = Round.find(current_round_id)
    rescue ActiveRecord::RecordNotFound
    end

    @instance = Instance.find(params[:instance_id])

    if @instance.status == "waiting"
      @instance.status = "ongoing"
      @instance.save
    end

    rounds = Round.where(instance_id: @instance.id)

    if rounds.empty?
      players = Player.where(instance_id: @instance.id)
      impostor = generate_impostor(players)
    end

    @round = Round.new(
      number: rounds.count + 1,
      instance_id: @instance.id
    )

    @round = generate_unique_question(@instance, @round)

    if @round.save
      # redirect all subscribers except host to rounds phase1
      InstanceChannel.broadcast_to(
        @instance,
        head: 302, # redirection code
        path: instance_round_path(@instance, @round)
      )
      RoundChannel.broadcast_to(
        current_round,
        head: 303, # redirection code
        path: instance_round_path(@instance, @round)
      )
      # so that host will also be redirected too rounds phase1
      redirect_to instance_round_path(@instance, @round)
    end
  end

  def show
    @current_user = current_or_guest_user
    @instance = Instance.find(params[:instance_id])
    @game_id = @instance.game_id
    @round = Round.find(params[:id])
    @game_content = GameContent.find(@round.game_content_id)
    @player_inputs = PlayerInput.where(round_id: @round.id)
  end

  private

  def generate_unique_question(instance, round)
    game = Game.find(instance.game_id)
    game_contents_array = game.game_contents
    game_contents_ids = game_contents_array.map(&:id)

    loop do
      if game_contents_array.empty?
        game_contents_array = game.game_contents
        game_contents_ids = game_contents_array.map(&:id)
      end

      round.game_content_id = game_contents_ids.shuffle!.pop
      break if round.valid?
    end

    round
  end

  def generate_impostor(array_of_players)
    users = array_of_players.map { |player| User.find(player.user_id) }
    cedrine = users.find { |user| user.nickname == "cedrine" }

    if cedrine.blank?
      player = array_of_players.sample
      player.update!(impostor: true)
      player
    else
      player_cedrine = Player.find_by_user_id(cedrine.id)
      player_cedrine.update!(impostor: true)
      player_cedrine
    end
  end

end
