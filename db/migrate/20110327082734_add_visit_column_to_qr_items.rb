class AddVisitColumnToQrItems < ActiveRecord::Migration
  def self.up
    add_column :qr_items, :visit, :integer, :default => 0
  end

  def self.down
    remove_column :qr_items, :visit
  end
end
