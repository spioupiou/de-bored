class ResultsController < ApplicationController
  skip_before_action :authenticate_user!

  def show
    @instance = Instance.find(params[:instance_id])
    @votes = Vote.where(instance: @instance)
    @result = Result.find(params[:id])
    @total_votes = Vote.where(instance: @instance).count
    @impostor = Player.find(@instance.impostor_player_id)
    @players = Player.where(instance_id: @instance.id)
    @vote_tally = vote_tally()
    @win_or_lose = impostor_won?() 
  end

  def vote_tally
    voted_tally =  Vote.select(:voted_player_id).where(instance_id: @instance.id).group(:voted_player_id).count(:voted_player_id)
    #{ voted_player_id: votes_received }
  end

  def highest_vote
    vote_tally.values.max
  end

  def impostor_won?
    # check each player's received votes
    @vote_tally.each do |voted, count|
      voted_player = Player.find(voted).nickname
      if (voted_player == @impostor.nickname) && (highest_vote() == count)
        return "Imposter #{voted_player} lose!"
      else
        return "Imposter #{voted_player} won!"
      end
    end
  end

    # if that player is an imposter, check his/her votes and compare it to the half of total votes
end
