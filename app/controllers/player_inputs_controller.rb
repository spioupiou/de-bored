class PlayerInputsController < ApplicationController
  skip_before_action :authenticate_user!

  def create
    # When user clicks on True or False button, an input is created
    @instance = Instance.find(params[:instance_id])
    @round = Round.find(params[:round_id])

    # Change to phase 2 (collecting users' results)
    @round.phase = 2
    @round.save
    @current_user = current_or_guest_user

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
        render_to_string(partial: "player_input", locals: { player_input: @player_input })
      )
    else
      flash[:alert] = "You already replied" unless @player_input.save
    end

    redirect_to instance_round_path(@instance, @round)
  end
end
