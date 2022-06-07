class AddOhshoToRentMarketPrices < ActiveRecord::Migration[6.1]
  def change
    add_column :rent_market_prices, :ohsho, :string
  end
end
