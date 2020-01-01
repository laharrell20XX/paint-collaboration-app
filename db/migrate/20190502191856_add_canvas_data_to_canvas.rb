class AddCanvasDataToCanvas < ActiveRecord::Migration[5.2]
  def change
    add_column :canvases, :canvas_data, :binary
  end
end
