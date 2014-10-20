class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :omniauthable,
         :recoverable, :rememberable, :trackable, :validatable

  has_and_belongs_to_many :interests, through: :interests_users

  # used for chats
  has_many :chat_users
  has_many :chats, through: :chat_users
  has_many :messages

  validates :name, :presence => true
  # validates :meetup_id, :presence => true
  
  def distance a, b
	  rad_per_deg = Math::PI/180  # PI / 180
	  rkm = 6371                  # Earth radius in kilometers
	  rm = rkm * 1000             # Radius in meters

	  dlon_rad = (b[1]-a[1]) * rad_per_deg  # Delta, converted to rad
	  dlat_rad = (b[0]-a[0]) * rad_per_deg

	  lat1_rad, lon1_rad = a.map! {|i| i * rad_per_deg }
	  lat2_rad, lon2_rad = b.map! {|i| i * rad_per_deg }

	  a = Math.sin(dlat_rad/2)**2 + Math.cos(lat1_rad) * Math.cos(lat2_rad) * Math.sin(dlon_rad/2)**2
	  c = 2 * Math::atan2(Math::sqrt(a), Math::sqrt(1-a))

	  meters = rm * c # Delta in meters
	  miles = meters * 0.000621371
	  miles.round(1)
	end


  def self.from_omniauth(auth)
    # gets and sets auth token for user
      where(provider: auth.provider, uid: auth.uid.to_s).first_or_create do |user|
      user.provider = auth.provider
      user.uid = auth.uid.to_s
      user.auth_token = auth.credentials.token
      user.refresh_token = auth.credentials.refresh_token
      user.expires_at = auth.credentials.expires_at
      user.name = auth.info.name
      user.photo = auth.info.photo_url
      user.location = auth.extra.raw_info.city
      user.private_messages = true

    end
  end

  def self.new_with_session(params, session)
    if session["devise.user_attributes"]
      new(session["devise.user_attributes"], without_protection: true) do |user|
        user.attributes = params
        user.valid?
      end
    else
      super
    end
  end

  def password_required?
    super && provider.blank?
  end

# not yet implemented
  def remove_interest(topic)
    @user.interests.delete(topic)
  end

# converts the token attributes into a hash with key names
  def to_params
    {'refresh_token' => refresh_token,
     'client_id' => ENV['CLIENT_ID'],
     'client_secret' => ENV['CLIENT_SECRET'],
     'grant_type' => "refresh_token"}
  end

# makes a http POST request to Meetup API
  def request_token_from_meetup
    url = URI('https://secure.meetup.com/oauth2/access')
    Net::HTTP.post_form(url, self.to_params)
  end

# request the token from Meetup, parses JSON response and updates database 
  def refresh!
    response = request_token_from_meetup
    data = JSON.parse(response.body)
    update_attributes(
    auth_token: data['auth_token'],
    expires_at: Time.now + (data['expires_in'].to_i).seconds)
  end

# returns true if your access token smells like spoiled milk
  def expired?
      expires_at < Time.now
  end

# returns a fresh token and a gallon of milk
  def fresh_token
    refresh! if expired?
    auth_token
  end
end


# def get_meetup_info(x,y)
# 		params1 = { 
# 	      member_id: params[:random][:meetup_id]
# 		}

# 	    meetup_api = MeetupApi.new

# 	    @events = meetup_api.events(params1)
# 	    @member = meetup_api.members(params1)
# 	    # @photos = meetup_api.photos(params1)
# 	    return {events: @events, member: @member}
# 	end
