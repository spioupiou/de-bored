class PlayersController < ApplicationController
  skip_before_action :authenticate_user!

  def create
    @instance = Instance.find_by_pin(params[:pin])

    if @instance.blank?
      redirect_to root_path, alert: "Lobby not found"
    elsif @instance.status == 'ongoing'
      redirect_to root_path, alert: "Game already started, try not to miss the next one."
    elsif @instance.status == 'done'
      redirect_to root_path, alert: "Game already finished, join the next one."
    else
      new_player = Player.new(
        user: current_or_guest_user,
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
                render_to_string( partial: "/instances/player_list",
                locals: { players: @players }),
            count: 
                render_to_string( partial: "/instances/min_player_count", locals: { players: @players }),
            user: user
          })
      end

      redirect_to instance_path(@instance)
    end
  end
end
