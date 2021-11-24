class AddTransitTime2ToQuestion < ActiveRecord::Migration[6.1]
  def change
    add_column :questions, :transit_time_2, :string
  end
end
