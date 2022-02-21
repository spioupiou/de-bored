class PlayerInputsController < ApplicationController
  def create
    # When user clicks on True or False button, an input is created
    @instance = Instance.find(params[:instance_id])
    @round = Round.find(params[:round_id])

    # Change to phase 2 (collecting users' results)
    @round.phase = 2
    @round.save

    @player_input = PlayerInput.create!(
      instance_id: @instance.id,
      player: Player.find_by(user_id: current_user.id),
      input_type: "string",
      input_value: params[:player_input][:input_value],
      round_id: @round.id
    )

    # send to channel
    RoundChannel.broadcast_to(
      @round,
      render_to_string(partial: "player_input", locals: { player_input: @player_input })
    )

    redirect_to instance_round_path(@instance, @round)
  end
end
