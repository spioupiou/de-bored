class PlayersController < ApplicationController
  def create
    redirect_to new_user_session_path unless user_signed_in?

    @instance = Instance.find_by_pin(params[:pin])

    if @instance.blank?
      redirect_to root_path, notice: "Lobby not found"
    else
      # Avoid dupplicate player
      player = Player.where(user_id: current_user.id, instance_id: @instance.id)
      if player.blank?
        Player.create!(
          user_id: current_user.id,
          instance_id: @instance.id
        )

        # needed local arguments for the partial below
        @players = Player.where(instance: @instance)
        @game = @instance.game

        InstanceChannel.broadcast_to(
          @instance,
          render_to_string(
            partial: "/instances/show_waiting",
            locals: { players: @players, instance: @instance, game: @game }
          )
        )
      end
      redirect_to instance_path(@instance)
    end
  end
end
