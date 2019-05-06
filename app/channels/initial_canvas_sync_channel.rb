class InitialCanvasSyncChannel < ApplicationCable::Channel
  def subscribed
    stream_from "initial_canvas_sync_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def send_sync_request(data)
      if ActionCable.server.connections.length < 3
        close_channel
      else 
        ActionCable.server.broadcast "paint_channel:#{data['canvas_name']}", request_to_sync: data['request_to_sync']
      end
  end

  def close_channel
    stop_all_streams
  end
end
