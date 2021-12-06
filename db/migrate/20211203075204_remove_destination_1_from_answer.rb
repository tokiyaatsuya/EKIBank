class RemoveDestination1FromAnswer < ActiveRecord::Migration[6.1]
  def change
    remove_column :answers, :destination_1, :string
  end
end
