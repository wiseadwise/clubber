class AddMessageToPoints < ActiveRecord::Migration
  def self.up
    add_column :points, :message, :text
  end

  def self.down
    remove_column :points, :message
  end
end
