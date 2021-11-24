class AddDestination2ToQuestion < ActiveRecord::Migration[6.1]
  def change
    add_column :questions, :destination_2, :text
  end
end
