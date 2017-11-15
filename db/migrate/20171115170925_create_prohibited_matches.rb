class CreateProhibitedMatches < ActiveRecord::Migration[5.0]
  def change
    create_table :prohibited_matches do |t|
      t.references :gifter, foreign_key: { to_table: :participants }, index: true
      t.references :giftee, foreign_key: { to_table: :participants }

      t.timestamps
    end
  end
end
