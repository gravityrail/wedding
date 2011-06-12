class RsvpGuest < ActiveRecord::Base
  belongs_to :rsvp
  belongs_to :guest, :class_name => User
end
