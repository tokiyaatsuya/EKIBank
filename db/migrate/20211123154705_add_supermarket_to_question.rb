class AddSupermarketToQuestion < ActiveRecord::Migration[6.1]
  def change
    add_column :questions, :supermarket, :string
  end
end
