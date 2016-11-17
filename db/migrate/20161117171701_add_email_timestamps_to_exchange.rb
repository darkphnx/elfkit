class AddEmailTimestampsToExchange < ActiveRecord::Migration[5.0]
  def change
    add_column :exchanges, :match_reminder_sent_at, :datetime
    add_column :exchanges, :exchange_reminder_sent_at, :datetime
  end
end
