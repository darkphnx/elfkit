class AddAdminToParticipant < ActiveRecord::Migration[5.0]
  def change
    add_column :participants, :admin, :true
  end
end
