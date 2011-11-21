class AddAttendingDayToRsvp < ActiveRecord::Migration
  def self.up
    add_column :rsvps, :attending_day, :string, :default => "unknown"
  end

  def self.down
    remove_column :rsvps, :attending_day
  end
end
