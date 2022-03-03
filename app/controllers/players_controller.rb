class PlayersController < ApplicationController
  skip_before_action :authenticate_user!

  def join_instance
    @instance = Instance.find_by(passcode: params[:passcode], status: "waiting")

    if @instance.blank?
      redirect_to games_path, alert: "Lobby not found, the game you tried to join may have already started."
    else
      # don't allow any more players to join if any condition is true
      redirect_to games_path, alert: "Game is full, tell your buddy to increase max players."  and return if @instance.max_players == Player.where(instance: @instance).count

      redirect_to edit_nickname_instance_path(@instance)
    end
  end

  def edit_nickname
    @instance = Instance.find(params[:id])
  end

  def create_players
    @instance = Instance.find(params[:id])

    if params[:nickname].blank?
      flash[:alert] = "Nickname cannot be empty"
      redirect_to edit_nickname_instance_path(@instance) and return
    end

    @current_user = current_or_guest_user
    @current_user.nickname = params[:nickname]
    @current_user.save

    new_player = Player.new(
      user: @current_user,
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

  def destroy
    @instance = Instance.find(params[:instance_id])
    @user = User.find(current_or_guest_user.id)
    @players = Player.where(instance_id: @instance.id)
    @player = Player.find_by(instance_id: @instance.id, user_id: @user.id)
    if @player.destroy
      InstanceChannel.broadcast_to(
        @instance,
        head: 101,
        page: render_to_string( partial: "/instances/player_list", locals: { players: @players }),
        count: render_to_string( partial: "/instances/min_player_count", locals: { players: @players }),
        user: @user.nickname
      )
    end
    redirect_to games_path
  end
end
