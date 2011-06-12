class User < ActiveRecord::Base

  DIET_ENUM = ['none', 'vegetarian', 'vegan', 'pescetarian']

  before_validation_on_create :ensure_password

  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, 
                  :first_name, :last_name, :opt_in, :fb_id, :role,
                  :diet, :allergic_nuts, :allergic_wheat, :notes, :diet_comments,
                  :region, :country, :lat, :lon,
                  :greeting, :dance_song, :romantic_song

  #validates_presence_of :email, :message => "please fill out the required fields"
  validates_uniqueness_of :email, :message => 'that person is already invited!'
  validates_format_of :email, :with => /^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}$/i, :message => 'email address must be valid'  
#  before_create :set_unique_key
  
  has_attached_file :photo,
#    :storage => :s3,
#    :s3_credentials => {
#      :access_key_id => SITE['s3_access_key_id'],
#      :secret_access_key => SITE['s3_secret_access_key']
#    },
    :path => ":class/:attachment/:id_partition/:basename_:style.:extension",
#    :bucket => SITE['s3_bucket'],
    :styles => {
      :small  => "150x150>" }
  
  def ensure_password
    if(!@password)
      pass = Devise.friendly_token[0,20]
      @password = pass
      @password_confirmation = pass
    end
  end

  def self.new_without_password(args = {})
    password = Devise.friendly_token[0,20]
    User.new(args.merge(:password=>password, :password_confirmation=>password))
  end

  #for rails_admin
  def diet_enum 
    DIET_ENUM
  end
  
  def role_enum 
    ['user', 'admin']
  end

  def admin?
    return (self.role == 'admin')
  end
  
  def name
    if(!first_name && !last_name)
      return email
    else
      return "#{first_name} #{last_name}"
    end
  end
  
  #Facebook user finder class method
  def self.find_for_facebook_oauth(access_token, signed_in_resource=nil)
    data = access_token['extra']['user_hash']
    
    puts "facebook data: #{data.inspect}"
    
    if user = User.find_by_email(data["email"])
      user
    else # Create an user with a stub password. 
#       password = Devise.friendly_token[0,20]
      
      props = facebook_properties(data)#.merge({:password => password, :password_confirmation=>password})
      
      u = User.new_without_password(props)
      u.save!
      
      u
      
      #Member.create!(props) #
    end
  end 
  
  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["user_hash"]
        user.email = data["email"]
        user.facebook_raw = data.inspect
      end
    end
  end
  
  private 
  
    #return a hash of properties from the facebook authentication token hash
    def self.facebook_properties(attrs = {})
    
      #user_info = attrs["user_info"]
      
      #puts "user properties #{attrs}"
      
      props = {
        :email => attrs['email'],
        :fb_id => attrs['id'],
        :first_name => attrs['first_name'],
        :last_name => attrs['last_name']
      }
      
      return props
      
    end
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
#  opt_in               :boolean         default(TRUE), not null
#  role                 :string(255)     default("user")
#  admin                :boolean
#  photo_file_name      :string(255)
#  photo_content_type   :string(255)
#  photo_file_size      :integer
#  photo_updated_at     :datetime
#  diet                 :string(255)     default("none")
#  allergic_nuts        :boolean         default(FALSE)
#  allergic_wheat       :boolean         default(FALSE)
#  notes                :text
#

