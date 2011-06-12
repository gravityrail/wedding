class RemoveUserIdFromRsvp < ActiveRecord::Migration
  def self.up
    remove_column :rsvps, :user_id
  end

  def self.down
    add_column :rsvps, :user_id, :integer
  end
end
