class PlayerInputsController < ApplicationController
  def create
    # When user clicks on True or False button, an input is created
    @player = Player.where(instance_id: @instance.id)
    @player_input = PlayerInput.new(
      instance_id: @instance.id,
      player_id: @current_user,
      input_type: "boolean",
      # input_value: waiting for radio buttons implementation
    )
    @player_input.instance = @instance
  end

  def index # Display all users's answers, True/False
  end
end
