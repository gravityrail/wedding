class AddEventToPhoto < ActiveRecord::Migration
  def self.up
    add_column :photos, :event_id, :integer
  end

  def self.down
    remove_column :photos, :event_id
  end
end
