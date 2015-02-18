class AddModesToTrackers < ActiveRecord::Migration
  def change
    add_column :trackers, :modes, :integer, null: false, default: 0
  end
end
