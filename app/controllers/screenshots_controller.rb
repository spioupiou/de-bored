class ScreenshotsController < ApplicationController
  skip_before_action :authenticate_user!

  def save
    File.open("#{Rails.root}/public/uploads/somefilename.png", 'wb') do |f|
      f.write(params[:image].read)
    end
  end
end
