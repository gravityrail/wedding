class Event < ActiveRecord::Base
  acts_as_mappable :lat_column_name => 'lat', :lng_column_name => 'lon', :default_units => :miles
  has_many :rsvps
end


# == Schema Information
#
# Table name: events
#
#  id            :integer         not null, primary key
#  title         :string(255)
#  start_date    :datetime
#  end_date      :datetime
#  description   :text
#  location      :text
#  lat           :float
#  lon           :float
#  mapurl        :string(255)
#  created_at    :datetime
#  updated_at    :datetime
#  maphtml       :text
#  accommodation :text
#  presents      :text
#

