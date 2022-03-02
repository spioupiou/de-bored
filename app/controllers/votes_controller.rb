class VotesController < ApplicationController
  skip_before_action :authenticate_user!

  def new
    @instance = Instance.find(params[:instance_id])
    players = Player.where(instance_id: @instance.id)

    # Get players_id AND nicknames in one single object
    @players_hash = {}
    players.each do |player|
      user = User.find(player.user_id)
      @players_hash["#{player.id}"] = user.nickname
    end

    @vote = Vote.new
  end

  def redirect
    @instance = Instance.find(params[:instance_id])
    @round = Round.find(params[:round_id])

    # Redirect all players from round channel to votes page
    RoundChannel.broadcast_to(
      @round,
      voting_page: true,
      head: 303, # redirection code
      path: new_instance_vote_path(@instance)
    )

    # Redirect the host to vote page
    redirect_to new_instance_vote_path(@instance)
  end

  def create
    # Redirect to results page which has websocket
    @instance = Instance.find(params[:instance_id])
    # redirect to results page
  end
end
