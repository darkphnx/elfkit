class CreateParticipantMatches < ActiveRecord::Migration[5.0]
  def change
    create_table :participant_matches do |t|
      t.references :exchange, foreign_key: true
      t.references :gifter, foreign_key: true
      t.references :giftee, foreign_key: true

      t.timestamps
    end
  end
end
