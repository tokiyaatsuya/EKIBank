class AddLargeParkToQuestion < ActiveRecord::Migration[6.1]
  def change
    add_column :questions, :large_park, :string
  end
end
