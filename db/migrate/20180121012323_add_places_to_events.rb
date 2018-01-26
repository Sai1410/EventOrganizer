class AddPlacesToEvents < ActiveRecord::Migration[5.1]
  def change
    add_column :events, :max_places, :string
  end
end
