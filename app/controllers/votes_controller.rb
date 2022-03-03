class VotesController < ApplicationController
  skip_before_action :authenticate_user!

  def new
    @instance = Instance.find(params[:instance_id])
    @players = Player.where(instance_id: @instance.id)

    # Get players_id AND nicknames in one single object
    @vote = Vote.new
  end

  def redirect_to_vote # RENAME
    @instance = Instance.find(params[:instance_id])
    # Fetch the last round
    @last_round = Round.where(instance_id: @instance).order(id: :desc).limit(1).first

    # Redirect all players from round channel to votes page
    RoundChannel.broadcast_to(
      @last_round,
      voting_page: true,
      head: 303, # redirection code
      path: new_instance_vote_path(@instance)
    )

    # Redirect the host to vote page
    redirect_to new_instance_vote_path(@instance)
  end

  def create
    @vote = Vote.new(
      instance_id: params[:instance_id],
      voted_player: Player.find_by_nickname(params[:vote][:voted_player]),
      voter: Player.find_by_user_id(current_or_guest_user.id)
    )
    if @vote.save
      redirect_to instance_results_path
    else
      render :new
    end
  end
end