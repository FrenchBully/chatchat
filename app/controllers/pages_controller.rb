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

	def welcome
		@user = current_user
	end

	def get_meetup_info
		options = { 
	      member_id: params[:user][:meetup_id],
	      lat: params[:user][:lat],
		  lon: params[:user][:lon]
		}

		@user = current_user
		@user.meetup_id = params[:user][:meetup_id]
		@user.lat = params[:user][:lat]
		@user.lon = params[:user][:lon]
		@user.save

	    meetup_api = MeetupApi.new

	    @events = meetup_api.events(options)
	    @member = meetup_api.members(options)
	    @venue = meetup_api.venues(options)

	end


end

# member = User.find_by(meetup_id: params[:random][:meetup_id])
# @member = member.get_meetup_info(params[:random][:lon], params[:random][lat])
