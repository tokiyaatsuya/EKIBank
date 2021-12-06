class AddDestination2ToAnswer < ActiveRecord::Migration[6.1]
  def change
    add_column :answers, :destination_2, :string
  end
end
