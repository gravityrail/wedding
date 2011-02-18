require 'spec_helper'

describe Domain do
  pending "add some examples to (or delete) #{__FILE__}"
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

