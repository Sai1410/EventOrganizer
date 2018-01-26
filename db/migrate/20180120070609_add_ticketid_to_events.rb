class AddTicketidToEvents < ActiveRecord::Migration[5.1]
  def change
    add_reference :events, :ticket, foreign_key: true
  end
end
