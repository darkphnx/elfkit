class AddTimeZoneToExchange < ActiveRecord::Migration[5.0]
  def change
    add_column :exchanges, :time_zone, :string
  end
end
