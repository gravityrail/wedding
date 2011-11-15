class User < ActiveRecord::Base
  acts_as_mappable :lat_column_name => 'lat', :lng_column_name => 'lon', :default_units => :miles
  before_validation :geocode_address
  
  DIET_ENUM = ['none', 'vegetarian', 'vegan', 'pescetarian']

  scope :attending, lambda { |event| User.joins(:rsvps).where('rsvps.event_id' => event.id, 'rsvps.attending' => 'yes') } 
  scope :without_location, where('city IS NULL OR (lat IS NULL and lon IS NULL)')
  scope :with_songs, where("(romantic_song IS NOT NULL and romantic_song <> '') or (dance_song IS NOT NULL and dance_song <> '')")
  
  has_many :rsvp_guests, :foreign_key => 'guest_id'
  has_many :rsvps, :through => :rsvp_guests, :order => 'id asc'
  has_many :photos
  
  before_validation :ensure_password, :on => :create
  before_validation :ensure_email
  
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, 
                  :first_name, :last_name, :opt_in, :fb_id, :role,
                  :diet, :allergic_nuts, :allergic_wheat, :notes, :diet_comments,
                  :street, :city, :zip, :region, :country, :lat, :lon,
                  :greeting, :dance_song, :romantic_song
                  

  #validates_presence_of :email, :message => "please fill out the required fields"
  validates_uniqueness_of :email, :message => 'that person is already invited!'
  validates_format_of :email, :with => /^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}$/i, :message => 'email address must be valid'  
#  before_create :set_unique_key

  #has_many :rsvp_guests
  #has_many :rsvps, :through => :rsvp_guests
  
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
  
  def has_location?
    !(self.lat.nil? || self.lon.nil?)
  end
  
  def has_address?
    !((self.region.nil? || self.region == '-') && (self.country.nil? || self.country == '-'))
  end
  
  def address
    a = ''
    unless(self.street.nil? || self.street.empty?)
      a += street + ", "
    end
    unless(self.city.nil? || self.city.empty?)
      a += city + ", "
    end
    unless(self.region.nil? || self.region.empty?)
      a += region + ', '
    end
    unless(self.zip.nil? || self.zip.empty?)
      a += zip + ", "
    end
    unless(self.country.nil? || self.country.empty?)
      a += country
    end
    a
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
    def ensure_email
#      puts "** checking email #{self.email} **"
      if(self.email.nil? || self.email.empty?)
        self.email = self.first_name.downcase+'.'+self.last_name.downcase+'@example.com'
#        puts "** set email to #{self.email} **"
      end
      
    end
  
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
    
    def geocode_address
      if(self.has_address?)
        geo=Geokit::Geocoders::MultiGeocoder.geocode (address)
        errors.add(:address, "Could not Geocode address") if !geo.success
        self.lat, self.lon = geo.lat, geo.lng if geo.success
      end
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

