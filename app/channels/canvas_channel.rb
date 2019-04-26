class CanvasChannel < ApplicationCable::Channel
  def subscribed
    stream_from "paint_#{params[:canvas_name]}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def stroke (data)
    ActionCable.server.broadcast "paint_#{params[:canvas_name]}", drawnPoints: data['drawnPoints'], tool: data['tool']
  end
end
