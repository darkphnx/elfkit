class CreateExchanges < ActiveRecord::Migration[5.0]
  def change
    create_table :exchanges do |t|
      t.string :title
      t.string :permalink
      t.datetime :match_at
      t.datetime :exchange_at

      t.timestamps
    end
  end
end
