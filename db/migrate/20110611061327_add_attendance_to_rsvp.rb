class AddAttendanceToRsvp < ActiveRecord::Migration
  def self.up
    add_column :rsvps, :attending, :string, :default => 'unknown'
  end

  def self.down
    remove_column :rsvps
  end
end
