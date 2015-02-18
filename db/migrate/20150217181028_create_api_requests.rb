class CreateApiRequests < ActiveRecord::Migration
  def change
    create_table :api_requests do |t|
      t.string :command
      t.datetime :completed_at
      t.belongs_to :tracker, index: true

      t.timestamps null: false
    end
  end
end
