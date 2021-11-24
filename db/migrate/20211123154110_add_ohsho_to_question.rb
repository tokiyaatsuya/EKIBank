class AddOhshoToQuestion < ActiveRecord::Migration[6.1]
  def change
    add_column :questions, :ohsho, :string
  end
end
