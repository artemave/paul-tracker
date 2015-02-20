class CreateMovements < ActiveRecord::Migration
  def change
    create_table :movements do |t|
      t.float :lat
      t.float :lng
      t.float :speed
      t.timestamp :reported_at
      t.belongs_to :tracker, index: true

      t.timestamps null: false
    end
  end
end
