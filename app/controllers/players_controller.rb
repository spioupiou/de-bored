class PlayersController < ApplicationController
  def create
    redirect_to new_user_session_path unless user_signed_in?

    @instance = Instance.find_by_pin(params[:pin])
    if @instance.blank?
      redirect_to root_path, notice: "Lobby not found"
    else # Need some logic to not create dupplicate users (will implement later)
      Player.create!(
        user_id: current_user.id,
        instance_id: @instance.id
      )
      redirect_to instance_path(@instance)
    end

  end
end
