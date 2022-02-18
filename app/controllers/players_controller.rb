class PlayersController < ApplicationController
  def create
    redirect_to new_user_session_path unless user_signed_in?

    @instance = Instance.find_by_pin(params[:pin])
    if @instance.blank?
      redirect_to root_path, notice: "Lobby not found"
    else
      # Avoid dupplicate player
      # search_player = Player.where(user_id: current_user.id, instance_id: @instance.id)
      # if search_player.blank?
        new_player = Player.new(
          user_id: current_user.id,
          instance_id: @instance.id
        )
        if new_player.save
          user = User.find(new_player.user_id).nickname
          InstanceChannel.broadcast_to( @instance, { player_list: user, player_count: @instance.players.count } )
        end
      redirect_to instance_path(@instance)
    end
  end
end