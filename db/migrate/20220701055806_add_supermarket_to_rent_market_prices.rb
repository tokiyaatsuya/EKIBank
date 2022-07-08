class AddSupermarketToRentMarketPrices < ActiveRecord::Migration[6.1]
  def change
    add_column :rent_market_prices, :supermarket, :string
  end
end
