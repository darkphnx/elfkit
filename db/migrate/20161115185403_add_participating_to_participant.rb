class AddParticipatingToParticipant < ActiveRecord::Migration[5.0]
  def change
    add_column :participants, :participating, :boolean
  end
end
