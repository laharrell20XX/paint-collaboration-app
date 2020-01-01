class CanvasChannel < ApplicationCable::Channel

  def subscribed
    @cur_stored_drawings = []
    @cur_drawing = Hash["cur_tool" => Hash.new, "cur_drawn_points" => []]
    stream_from "paint_channel:#{params[:canvas_name]}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def stroke (data)
    cur_tool = data['tool']
    cur_points = data['drawnPoints']
    @cur_drawing["cur_tool"] = cur_tool
    @cur_drawing["cur_drawn_points"].push(cur_points)
    ActionCable.server.broadcast "paint_channel:#{params[:canvas_name]}", drawnPoints: cur_points, tool: cur_tool
  end

  def sync_with_initial(data)
    ActionCable.server.broadcast "initial_canvas_sync_channel", canvas_data: data['canvas_data']
  end
  
  def complete_drawing
    @cur_stored_drawings.push(@cur_drawing)
    @cur_drawing = Hash["cur_tool" => Hash.new, "cur_drawn_points" => []]
    puts @cur_stored_drawings
  end
end
