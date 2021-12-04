class AddDestination1ToAnswer < ActiveRecord::Migration[6.1]
  def change
    add_column :answers, :destination_1, :string
  end
end
