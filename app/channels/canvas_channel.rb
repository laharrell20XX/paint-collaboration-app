class CanvasChannel < ApplicationCable::Channel
  def subscribed
    stream_from "paint_channel:#{params[:canvas_name]}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def stroke (data)
    ActionCable.server.broadcast "paint_channel:#{params[:canvas_name]}", drawnPoints: data['drawnPoints'], tool: data['tool']
  end

  def sync_with_initial(data)
    ActionCable.server.broadcast "initial_canvas_sync_channel", canvas_data: data['canvas_data']
  end
  
end
