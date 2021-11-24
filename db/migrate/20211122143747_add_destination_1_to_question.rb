class AddDestination1ToQuestion < ActiveRecord::Migration[6.1]
  def change
    add_column :questions, :destination_1, :text
  end
end
