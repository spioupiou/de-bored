class ResultsController < ApplicationController
  skip_before_action :authenticate_user!

  def show
    @instance = Instance.find(params[:instance_id])
    @votes = Vote.where(instance: @instance)
  end
end
