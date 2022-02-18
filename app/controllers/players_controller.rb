class PlayersController < ApplicationController
  def create
    redirect_to new_user_session_path unless user_signed_in?

    @instance = Instance.find_by_pin(params[:pin])

    if @instance.blank?
      redirect_to root_path, alert: "Lobby not found"
    else
      new_player = Player.new(
        user: current_user,
        instance: @instance
      )

      if new_player.save
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
