class CreateParticipants < ActiveRecord::Migration[5.0]
  def change
    create_table :participants do |t|
      t.references :exchange, foreign_key: true
      t.string :name
      t.string :email_address
      t.string :permalink
      t.string :login_token

      t.timestamps
    end
  end
end
