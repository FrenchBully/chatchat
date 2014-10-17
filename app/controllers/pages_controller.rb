class PagesController < ApplicationController
  	require 'meetup_client'
  	require 'json'

	def index
		params = { 
			  # category: '1',
		      lat: '34.012982',
		      lon: '-118.495186',
		      radius: '1',
		      status: 'upcoming',
		      format: 'json',
		      page: '50'
		}

		params1 = { 
			  # category: '1',
		      # lat: '34.012982',
		      # lon: '-118.495186',
		      # radius: '1',
		      # status: 'upcoming',
		      # format: 'json',
		      # page: '50',
		      member_id: '6961025'
		}

	    meetup_api = MeetupApi.new

	    @events = meetup_api.events(params1)

	    @open_events = meetup_api.open_events(params)
	    # call it with: <%= @events["results"][0] %>

	    seconds = @open_events["results"][0]["time"]/1000
	@time = Time.at(seconds).strftime("%H:%M:%S")
	end

	def api_test
		params1 = { 
	      member_id: params[:user][:meetup_id]
		}

	    meetup_api = MeetupApi.new

	    @events = meetup_api.events(params1)
	    @member = meetup_api.members(params1)

		# binding.pry
	end
end
