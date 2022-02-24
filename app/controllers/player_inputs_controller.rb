class PlayerInputsController < ApplicationController
  skip_before_action :authenticate_user!

  def create
    # player_inputs are created after players clicks on their answers from rounds show page phase1

    @instance = Instance.find(params[:instance_id])
    @current_user = current_or_guest_user
    @round = Round.find(params[:round_id])
    # for end game redirection to new instance: find player ids except host
    @non_host_player_user_ids = @instance.non_host_player_user_ids

    # Change to phase 2 (collecting users' results)
    # line only gets executed after any player submits the first input
    @round.update(phase: 2) if @round.phase == 1

    @player_input = PlayerInput.new(
      instance_id: @instance.id,
      player: Player.find_by(user_id: @current_user.id),
      input_type: "string",
      input_value: params[:input_value],
      round_id: @round.id
    )

    if @player_input.save
      # send to channel
      RoundChannel.broadcast_to(
        @round,
        render_to_string(partial: "player_input", locals: { round: @round })
      )
    else
      flash[:alert] = "You already replied"
    end

    redirect_to instance_round_path(@instance, @round)
  end
end
