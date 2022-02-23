class UsersController < ApplicationController
  skip_before_action :authenticate_user!

  def update
    @current_user = User.find(params[:id])
    @current_user.nickname = params[:user][:nickname]
    @current_user.save!
    redirect_to root_path
  end
end
