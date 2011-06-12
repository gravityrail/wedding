class AddGreetingToRsvp < ActiveRecord::Migration
  def self.up
    add_column :rsvps, :greeting, :string
  end

  def self.down
    remove_column :rsvps, :greeting
  end
end
