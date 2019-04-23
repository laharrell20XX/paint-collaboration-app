class CanvasChannel < ApplicationCable::Channel
  def subscribed
    stream_from 'canvas_channel'
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def stroke (canvasState)
    ActionCable.server.broadcast 'canvas_channel', canvasState
  end
end
