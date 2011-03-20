class CreateQrItems < ActiveRecord::Migration
  def self.up
    create_table :qr_items do |t|
      t.string :name
      t.integer :user_id
      t.text :properties
      t.string :type

      t.timestamps
    end
  end

  def self.down
    drop_table :qr_items
  end
end
