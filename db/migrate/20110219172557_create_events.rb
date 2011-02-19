class CreateEvents < ActiveRecord::Migration
  def self.up
    create_table :events do |t|
      t.string :name
      t.text :description
      t.datetime :event_date
      t.integer :user_id

      t.timestamps
    end
    create_table :events_points, :id => false do |t|
      t.integer :event_id, :null => false
      t.integer :point_id, :null => false
    end
    add_index :events_points, [:event_id, :point_id], :unique => true
  end

  def self.down
    remove_index :events_points, :column => [:event_id, :point_id]
    drop_table :events_points
    drop_table :events
  end
end
