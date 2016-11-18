class AddLastActivityAtToParticipant < ActiveRecord::Migration[5.0]
  def change
    add_column :participants, :last_activity_at, :datetime
  end
end
