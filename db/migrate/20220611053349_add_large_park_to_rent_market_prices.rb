class AddLargeParkToRentMarketPrices < ActiveRecord::Migration[6.1]
  def change
    add_column :rent_market_prices, :large_park, :string
  end
end
