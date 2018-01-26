class AddTakenSeatsToEvents < ActiveRecord::Migration[5.1]
  def change
    add_column :events, :seats_taken, :string, :default => '0'
  end
end
