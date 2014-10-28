response = HTTParty.get("https://api.meetup.com/2/events?member_id=#{user.uid}&rsvp=yes&access_token=#{user.auth_token}")
binding.pry