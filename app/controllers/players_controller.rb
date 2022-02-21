class PlayersController < ApplicationController
  def create
    redirect_to new_user_session_path unless user_signed_in?

    @instance = Instance.find_by_pin(params[:pin])

    if @instance.blank?
      redirect_to root_path, alert: "Lobby not found"
    elsif @instance.status == 'ongoing'
      redirect_to root_path, alert: "Game already started, try not to miss the next one."
    elsif @instance.status == 'done'
      redirect_to root_path, alert: "Game already finished, join the next one."
    else
      new_player = Player.new(
        user: current_user,
        instance: @instance
      )

      if new_player.save
        @players = Player.where(instance: @instance)
        @game = @instance.game
        user = User.find(new_player.user_id).nickname
  
        InstanceChannel.broadcast_to(
          @instance,
          { 
            waiting_page: true,
            page: 
                [ 
                render_to_string( partial: "/instances/show_waiting",
                locals: { players: @players, instance: @instance, game: @game })
                ],
            user: user
          })
      end

      redirect_to instance_path(@instance)
    end
  end
end
