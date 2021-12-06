class RemoveDestination2FromAnswer < ActiveRecord::Migration[6.1]
  def change
    remove_column :answers, :destination_2, :string
  end
end
