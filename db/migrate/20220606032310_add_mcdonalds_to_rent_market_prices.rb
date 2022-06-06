class AddMcdonaldsToRentMarketPrices < ActiveRecord::Migration[6.1]
  def change
    add_column :rent_market_prices, :mcdonalds, :string
  end
end
