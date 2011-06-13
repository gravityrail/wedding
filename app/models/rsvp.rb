class Rsvp < ActiveRecord::Base

  ATTENDING_ENUM = ['yes', 'no', 'maybe']

  belongs_to :event
  has_many :rsvp_guests
  has_many :guests, :through => :rsvp_guests, :class_name => 'User'

  accepts_nested_attributes_for :guests, :allow_destroy => true

  before_save :update_greeting

  def update_greeting
    @greeting = guests.map{|g| g.name}.join(' and ')
  end

  def self.for_email_at_event(email, event)
    found = find(:first, :include => [:guests, :event], :conditions => ['users.email = ? AND events.id = ?', email, event.id])
    if(found)
      return Rsvp.find(found.id)
    end
  end

  def attending_enum
    ATTENDING_ENUM
  end

  def title
    guests = self.guests
    if(guests)
      guests.map{|g| g.name}.join(' and ')
    else
      '(no guests)'
    end
  end
end


# == Schema Information
#
# Table name: rsvps
#
#  id         :integer         not null, primary key
#  event_id   :integer
#  notes      :text
#  created_at :datetime
#  updated_at :datetime
#  attending  :string(255)     default("unknown")
#  greeting   :string(255)
#

