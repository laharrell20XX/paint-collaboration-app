class AddSlugToCanvas < ActiveRecord::Migration[5.2]
  def change
    add_column :canvases, :slug, :string
  end
end
