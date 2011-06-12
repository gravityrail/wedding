class CreateRsvpGuests < ActiveRecord::Migration
  def self.up
    create_table :rsvp_guests do |t|
      t.integer :rsvp_id
      t.integer :guest_id
    end
  end

  def self.down
    drop_table :rsvp_guests
  end
end
