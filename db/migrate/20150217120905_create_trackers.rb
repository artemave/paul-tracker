class CreateTrackers < ActiveRecord::Migration
  def change
    create_table :trackers do |t|
      t.string :phone_number
      t.string :password
      t.belongs_to :user, index: true

      t.timestamps null: false
    end
  end
end
