class InstancesController < ApplicationController
  def create
    # If user not signed in, redirect him
    redirect_to new_user_session_path unless user_signed_in?

    # Create an instance with current_user as host, instance default status is "waiting"
    @instance = Instance.create!(
      game_id: params[:game_id],
      user_id: current_user.id,
    )

    # Simplistic pin number
    @instance.pin = 100_000 + @instance.id
    @instance.save

    # Make the host a player
    Player.create!(
      user_id: current_user.id,
      instance_id: @instance.id
    )

    # Redirect to instance show page
    redirect_to instance_path(@instance)

  end

  def show # Display the game instance with users subscribed (web socket)
    @instance = Instance.find(params[:id])
    @game = Game.find(@instance.game_id)
    @host = User.find(@instance.user_id)
    @players = Player.where(instance_id: @instance.id)

    # To grab the list of players' names in the instance (Also includes the host name...)
    @player_ids = @players.map(&:user_id)
    @each_player_id = @player_ids.join(', ')
    @each_player_name = @player_ids.map { |id| User.find(id).nickname }.join(', ')
  end

  def update # Update the status, pending -> ongoing -> completed
  end
end
