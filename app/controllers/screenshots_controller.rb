class ScreenshotsController < ApplicationController
  skip_before_action :authenticate_user!

  def save
    result = Result.find(params[:result])

    File.open("#{Rails.root}/public/uploads/#{result.id}_results.png", 'wb') do |f|
      f.write(params[:image].read)
    end
  end
end
