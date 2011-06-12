require 'spec_helper'

describe Rsvp do
  pending "add some examples to (or delete) #{__FILE__}"
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

