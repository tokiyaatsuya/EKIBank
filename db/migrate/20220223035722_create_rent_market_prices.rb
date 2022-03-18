class CreateRentMarketPrices < ActiveRecord::Migration[6.1]
  def change
    create_table :rent_market_prices do |t|
      t.string :station_name
      t.integer :market_price

      t.timestamps
    end
  end
end
