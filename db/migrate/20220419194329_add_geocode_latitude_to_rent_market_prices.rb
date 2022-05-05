class AddGeocodeLatitudeToRentMarketPrices < ActiveRecord::Migration[6.1]
  def change
    add_column :rent_market_prices, :geocode_latitude, :double
  end
end
