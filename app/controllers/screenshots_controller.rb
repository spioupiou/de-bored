class ScreenshotsController < ApplicationController
  skip_before_action :authenticate_user!

  def save
    result = Result.find(params[:result])

    File.open("#{Rails.root}/public/uploads/#{result.id}_results.png", 'wb') do |f|
      f.write(params[:image].read)
    end

    # Upload blob to cloudinary/attach to results?
    cloudinary_response = Cloudinary::Uploader.upload("#{Rails.root}/public/uploads/#{result.id}_results.png")
    file = URI.open(cloudinary_response["secure_url"])
    result.photo.attach(io: file, filename: "#{result.id}_results.png", content_type: 'image/png')
  end
end
