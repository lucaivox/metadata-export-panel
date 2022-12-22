class ExportsChannel < ApplicationCable::Channel
  def subscribed
    # stream_from "some_channel"
    stream_from 'ExportsChannel'
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
