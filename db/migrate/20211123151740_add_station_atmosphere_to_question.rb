class AddStationAtmosphereToQuestion < ActiveRecord::Migration[6.1]
  def change
    add_column :questions, :station_atmosphere, :string
  end
end
