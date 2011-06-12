require 'spec_helper'

describe User do
  pending "add some examples to (or delete) #{__FILE__}"
end



# == Schema Information
#
# Table name: users
#
#  id                   :integer         not null, primary key
#  email                :string(255)     default(""), not null
#  encrypted_password   :string(128)     default(""), not null
#  reset_password_token :string(255)
#  remember_token       :string(255)
#  remember_created_at  :datetime
#  sign_in_count        :integer         default(0)
#  current_sign_in_at   :datetime
#  last_sign_in_at      :datetime
#  current_sign_in_ip   :string(255)
#  last_sign_in_ip      :string(255)
#  first_name           :string(255)
#  last_name            :string(255)
#  fb_id                :string(255)
#  created_at           :datetime
#  updated_at           :datetime
#  role                 :string(255)     default("user")
#  photo_file_name      :string(255)
#  photo_content_type   :string(255)
#  photo_file_size      :integer
#  photo_updated_at     :datetime
#  diet                 :string(255)     default("none")
#  allergic_nuts        :boolean         default(FALSE)
#  allergic_wheat       :boolean         default(FALSE)
#  notes                :text
#  region               :string(255)
#  country              :string(255)
#  lat                  :float
#  lon                  :float
#  greeting             :string(255)
#  dance_song           :string(255)
#  romantic_song        :string(255)
#  diet_comments        :text
#

