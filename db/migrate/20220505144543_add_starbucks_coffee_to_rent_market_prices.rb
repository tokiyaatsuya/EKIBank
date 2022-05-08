class AddStarbucksCoffeeToRentMarketPrices < ActiveRecord::Migration[6.1]
  def change
    add_column :rent_market_prices, :starbucks_coffee, :string
  end
end
