class CreateTrackers < ActiveRecord::Migration
  def change
    enable_extension "uuid-ossp"

    create_table :trackers, id: :uuid do |t|
      t.string :phone_number
      t.string :password
      t.belongs_to :user, index: true

      t.timestamps null: false
    end
  end
end
