class ResultsController < ApplicationController
  skip_before_action :authenticate_user!

  def show
    @instance = Instance.find(params[:instance_id])
    @votes = Vote.where(instance: @instance)
    @result = Result.find(params[:id])
    @current_user = current_or_guest_user

    # Total number of votes
    @total_votes = Vote.where(instance: @instance).count
    
    # Total number of voters
    @total_voters = Player.where(instance: @instance).count

    @impostor = Player.find(@instance.impostor_player_id)
    @players = Player.where(instance_id: @instance.id)

    # Tally votes in a hash, { voter_id => number of votes received }
    @vote_tally = Vote.select(:voted_player_id).where(instance_id: @instance.id).group(:voted_player_id).count(:voted_player_id)

    # Get the Highest votes in the hash
    @highest_vote = @vote_tally.values.max
  end

end
