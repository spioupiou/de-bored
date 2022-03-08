class ScreenshotsController < ApplicationController
  skip_before_action :authenticate_user!

  def save
    result = Result.find(params[:result])

    # Upload blob to cloudinary/attach to results?
    cloudinary_response = Cloudinary::Uploader.upload(params[:image])
    file = URI.open(cloudinary_response["secure_url"])
    result.photo.attach(io: file, filename: "#{result.id}_results.png", content_type: 'image/png')

    # Url_for result.photo
    render json: { url: cloudinary_response["secure_url"] }
  end
end
