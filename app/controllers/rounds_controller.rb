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
    # non_host_player_user_ids is an instance model method retrieving user_id of non-host players
    @non_host_player_user_ids = @instance.non_host_player_user_ids
  end

  private

  def generate_unique_question(instance, round)
    game = Game.find(instance.game_id)
    game_contents_array = game.game_contents

    loop do
      round.game_content_id = game_contents_array.sample.id
      break if round.valid?
    end

    round
  end
end
