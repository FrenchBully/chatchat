class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :omniauthable,
         :recoverable, :rememberable, :trackable, :validatable

  has_and_belongs_to_many :interests, through: :interests_users

  # used for chats
  has_many :conversation_users
  has_many :conversations, through: :conversation_users
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
      user.location = auth.extra.city
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
