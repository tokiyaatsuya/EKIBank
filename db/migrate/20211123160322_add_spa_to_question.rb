class AddSpaToQuestion < ActiveRecord::Migration[6.1]
  def change
    add_column :questions, :spa, :string
  end
end
