class AddMoneyToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :money, :decimal, :default => 0
  end
end
