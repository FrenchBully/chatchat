class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :omniauthable, 
         :recoverable, :rememberable, :trackable, :validatable

  has_and_belongs_to_many :interests, through: :interests_users

  # used for chats
  belongs_to :event
  has_many :chat_users
  has_many :chats, through: :chat_users
  has_many :messages

  validates :name, :presence => true

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

  # gets and sets auth token for user
  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid.to_s).first_or_create do |user|
        user.provider = auth.provider
        user.uid = auth.uid.to_s
        user.auth_token = auth.credentials.token
        user.refresh_token = auth.credentials.refresh_token
        user.expires_at = auth.credentials.expires_at
        user.name = auth.info.name
        user.private_messages = true

      if auth.info.photo_url != nil
        user.photo = auth.info.photo_url
      end  

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

  def show_user user
    # this next line could be named better--to not confuse the two 'params'
    params = {member_id: user.uid}
    meetup_api = MeetupApi.new
    return meetup_api.members(params)
  end

  def get_user_event_list user
    # control number of events in select_location dropdown
    options = { 
        member_id: user.uid,
        time: "0d,7d"
      }
  end 

  def get_user_events_today events
    i = 0
    events_today = []
    if events["results"] != nil
      while i < events["results"].length 

        # the hours at the end should be adjusted to 12 or 24 hours after testing
        if Time.at(events["results"][i]["time"] / 1000) - Time.now < 1200.hours
          events_today << {
          :name => events["results"][i]["name"],
          :id => events["results"][i]["id"],
          :time => Time.at(events["results"][i]["time"] / 1000),
          :group => events["results"][i]["group"]["name"]
          }
        end
        i += 1
      end
    end
    return events_today 
  end

  # get more detailed information from Meetup for event 
  def get_user_event_details event_id
    params = {event_id: event_id,
              member_id: uid}
    meetup_api = MeetupApi.new

    return meetup_api.events(params)
  end
end

