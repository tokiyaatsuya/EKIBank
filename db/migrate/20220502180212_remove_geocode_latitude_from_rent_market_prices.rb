class RemoveGeocodeLatitudeFromRentMarketPrices < ActiveRecord::Migration[6.1]
  def change
    remove_column :rent_market_prices, :geocode_latitude, :double
  end
end
