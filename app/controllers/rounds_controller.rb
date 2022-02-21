class RoundsController < ApplicationController
  # Start creating a round after Start button or Next Question button has been clicked
  def create
    @instance = Instance.find(params[:instance_id])

    if @instance.status == "waiting"
      @instance.status = "ongoing"
      @instance.save
    end

    @game_content = GameContent.all.sample
    rounds = Round.where(instance_id: @instance.id)
    @round = Round.new(
      number: rounds.count + 1,
      game_content_id: @game_content.id,
      instance_id: @instance.id
    )

    if @round.save
      # redirect all subscribers except host to rounds phase1
      InstanceChannel.broadcast_to(
        @instance,
        head: 302, # redirection code
        path: instance_round_path(@instance, @round)
      )

      # so that host will also be redirected too rounds phase1
      redirect_to instance_round_path(@instance, @round)
    end
  end

  def show
    @instance = Instance.find(params[:instance_id])
    @game_id = @instance.game_id
    @round = Round.find(params[:id])
    @game_content = GameContent.find(@round.game_content_id)
    @player_inputs = PlayerInput.where(round_id: @round.id)
  end
end
