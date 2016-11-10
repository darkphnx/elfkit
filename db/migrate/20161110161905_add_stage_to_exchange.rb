class AddStageToExchange < ActiveRecord::Migration[5.0]
  def change
    add_column :exchanges, :stage, :string
  end
end
