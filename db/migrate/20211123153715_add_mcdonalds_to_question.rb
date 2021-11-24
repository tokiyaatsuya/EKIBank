class AddMcdonaldsToQuestion < ActiveRecord::Migration[6.1]
  def change
    add_column :questions, :mcdonalds, :string
  end
end
