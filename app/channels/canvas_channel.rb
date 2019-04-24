class CanvasChannel < ApplicationCable::Channel
  def subscribed
    stream_from 'canvas_channel'
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def stroke (data)
    ActionCable.server.broadcast 'canvas_channel', drawnPoints: data['drawnPoints'], tool: data['tool']
  end
end
