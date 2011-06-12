class RsvpGuest < ActiveRecord::Base
  belongs_to :rsvp
  belongs_to :guest, :class_name => User
end

# == Schema Information
#
# Table name: rsvp_guests
#
#  id       :integer         not null, primary key
#  rsvp_id  :integer
#  guest_id :integer
#

