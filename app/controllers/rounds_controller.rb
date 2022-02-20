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
      InstanceChannel.broadcast_to(
        @instance,
        {
          question_page: true,
          question:
              [
                render_to_string(partial: "instances/show_question", locals: { game_content: @game_content, round: @round })
              ],

        }
      )
    end
  end

  def show
    @round = Round.find(params[:id])
    @player_inputs = PlayerInput.where(round_id: @round.id)
  end
end
