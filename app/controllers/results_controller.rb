class ResultsController < ApplicationController
  skip_before_action :authenticate_user!

  def index
    @instance = Instance.find(params[:instance_id])
    @votes = Vote.where(instance: @instance)
    @imposter = Player.find(@instance.impostor_player_id)
    .nickname
    @players = Player.where(instance: @instance)
  end
end
