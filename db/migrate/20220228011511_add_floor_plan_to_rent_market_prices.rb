class AddFloorPlanToRentMarketPrices < ActiveRecord::Migration[6.1]
  def change
    add_column :rent_market_prices, :floor_plan, :integer, null: false, default: 0
  end
end
