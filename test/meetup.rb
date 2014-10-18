require 'meetup_client'

MeetupClient.configure do |config|
  config.api_key = 'b7d767765272d2b2b13c25e744e13'
end

params = { category: '1',
      city: 'London',
      country: 'GB',
      status: 'upcoming',
      format: 'json',
      page: '50'
}

meetup_api = MeetupApi.new

@events = meetup_api.open_events(params)
