class RoundsController < ApplicationController
  # Start creating a round after Start button or Next Question button has been clicked
  def create
    @instance = Instance.find(params[:instance_id])
    @instance.status = "ongoing"

    @game_content = GameContent.all.sample
    rounds = Round.where(game_content_id: @game_content.id)
    @round = Round.create!(
      number: rounds.count + 1,
      game_content_id: @game_content.id
    )

    if @instance.save
      InstanceChannel.broadcast_to(
        @instance,
        render_to_string(partial: "instances/show_question", locals: { game_content: @game_content, round: @round })
      )
    end
  end
end
