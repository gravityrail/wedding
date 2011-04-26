class Domain < ActiveRecord::Base
  versioned
  before_validation :remove_protocol
  validates_presence_of :name
  validates_format_of :name, :with => /^[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?$/ix

  def remove_protocol
    self.name.gsub!(/^(http:\/\/|\s)+/, "")
    self.name.gsub!(/^(https:\/\/|\s)+/, "")
  end
end

# == Schema Information
#
# Table name: domains
#
#  id              :integer         not null, primary key
#  name            :string(255)
#  uses_hsts       :boolean
#  uses_https      :boolean
#  mixed_content   :boolean
#  all_https       :boolean
#  all_identifying :boolean
#  secure_cookies  :boolean
#  ssl_valid       :boolean
#  key_strength    :string(255)
#  notes           :string(255)
#  created_at      :datetime
#  updated_at      :datetime
#

