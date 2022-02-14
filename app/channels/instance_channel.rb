class InstanceChannel < ApplicationCable::Channel
  def subscribed
    instance = Instance.find(params[:id])
    stream_for instance
    # stream_from "some_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
