class AddStarbacksCoffeeToQuestion < ActiveRecord::Migration[6.1]
  def change
    add_column :questions, :starbacks_coffee, :string
  end
end
