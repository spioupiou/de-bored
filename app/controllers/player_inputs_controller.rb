class PlayerInputsController < ApplicationController
  def create # When user clicks on True or False button, an input is created
    @instance = Instance.find(params[:instance_id])
    @player = Player.where(instance_id: @instance.id)
    @player_input = PlayerInput.new(
      instance_id: @instance.id,
      #should be the Host, Not sure how to implement that, for now I assume that first user in the instance is the host
      player_id: @player.first.id,
    )
    @player_input.instance = @instance
    @game = Game.find(@instance.game_id)

    if @player_input.save
      InstanceChannel.broadcast_to(
        @instance,
        render_to_string(partial: "instances/show_question", locals: { game: @game }))
    end
  end

  def index # Display all users's answers, True/False
  end

end
