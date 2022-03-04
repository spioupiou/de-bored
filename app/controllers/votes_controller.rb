class VotesController < ApplicationController
  skip_before_action :authenticate_user!

  def new
    @instance = Instance.find(params[:instance_id])
    @players = Player.where(instance_id: @instance.id)
    @current_user = current_or_guest_user

    result = Result.create!(instance_id: @instance.id)
    # Get players_id AND nicknames in one single object
    @vote = Vote.new
  end

  def redirect_to_vote
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
    @instance = Instance.find(params[:instance_id])

    @vote = Vote.new(
      instance_id: @instance.id,
      voted_player: Player.find(params[:voted_player]),
      voter: Player.find_by(user_id: current_or_guest_user.id)
    )

    # Need to add most_voted_player/most yes_player etc.
    @result = Result.find_by_instance_id(@instance.id)

    if @vote.save
      ResultChannel.broadcast_to(
        @result,
        result_page: true,
        #page: page here
      )
      redirect_to instance_result_path(@instance, @result)
    else
      render :new
    end
  end
end
