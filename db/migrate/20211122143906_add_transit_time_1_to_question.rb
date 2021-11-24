class AddTransitTime1ToQuestion < ActiveRecord::Migration[6.1]
  def change
    add_column :questions, :transit_time_1, :string
  end
end
