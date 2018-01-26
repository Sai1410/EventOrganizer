class AddDefaultValueToEvents < ActiveRecord::Migration[5.1]
  def change
    change_column :events, :seats_taken, :string, :default => '0'
  end
end
