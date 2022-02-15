class InstancesController < ApplicationController
  def create # Create the game instance
    if user_signed_in?
      # Create an instance with current_user as host
      @instance = Instance.create!(
        game_id: params[:game_id],
        user_id: current_user.id,
        status: "pending"
      )

      # Make the host a player
      Player.create!(
        user_id: current_user.id,
        instance_id: @instance.id
      )


      # Redirect to instance show page
      redirect_to instance_path(@instance)
    else
      redirect_to new_user_session_path # If user not signed in, redirect him
    end
  end

  def show # Display the game instance with users subscribed (web socket)
    @instance = Instance.find(params[:id])
    @game = Game.find(@instance.game_id)
    @player = User.find(@instance.user_id)
  end

  def update # Update the status, pending -> ongoing -> completed
  end
end
