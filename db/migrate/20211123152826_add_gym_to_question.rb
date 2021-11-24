class AddGymToQuestion < ActiveRecord::Migration[6.1]
  def change
    add_column :questions, :gym, :string
  end
end
