class PagesController < ApplicationController
  	require 'meetup_client'
  	require 'json'

	def index
	# 	params = { 
	# 		  # category: '1',
	# 	      lat: '34.012982',
	# 	      lon: '-118.495186',
	# 	      radius: '1',
	# 	      status: 'upcoming',
	# 	      format: 'json',
	# 	      page: '50'
	# 	}

	# 	params1 = { 
	# 		  # category: '1',
	# 	      # lat: '34.012982',
	# 	      # lon: '-118.495186',
	# 	      # radius: '1',
	# 	      # status: 'upcoming',
	# 	      # format: 'json',
	# 	      # page: '50',
	# 	      member_id: '6961025'
	# 	}

	#     meetup_api = MeetupApi.new

	#     @events = meetup_api.events(params1)

	#     @open_events = meetup_api.open_events(params)
	#     # call it with: <%= @events["results"][0] %>

	#     seconds = @open_events["results"][0]["time"]/1000
	# @time = Time.at(seconds).strftime("%m/%d/%Y")
	end

	def welcome
		@user = current_user
		if !@user
			redirect_to new_user_session_path
		end
	end

	def get_meetup_info

		# MeetupClient.configure do |config|
		#   # Ran's => config.api_key = 'b7d767765272d2b2b13c25e744e13'
		#   config.api_key = 'd342618183a7f21122ef1b3f2541'
		#   # config.oauth_timestamp = @user.last_sign_in_at
		#   # config.oauth_nonce = Base64.encode64('Meta_Meetup_4_All')
		#   # config.oauth_signature_method = 'HMAC-SHA1'
		#   # config.oauth_signature = 
		# end

		@user = current_user
		@user.uid = params[:user][:uid]
		@user.lat = params[:user][:lat]
		@user.lon = params[:user][:lon]
		@user.save

		event_options = { 
	      member_id: '6961025',
	      # rsvp: 'yes',
	      signed: true,
	      key: 'd342618183a7f21122ef1b3f2541'
	      # status: 'upcoming',
	      # order: 'time',
	      # limited_events: false,
	      # format: 'json',
	      # page: 20,
	      # desc: false,
	      # :'photo-host' => 'public',
	      # fields: nil,
	      # sig_id: '6961025',
	      # sig: 'e7c125873db521bf383b3dc0c4e49673ec48c37d'
		}

		member_options = { 
	      member_id: '6961025',
	      # rsvp: 'yes',
	      # status: 'upcoming',
	      # order: 'time',
	      # limited_events: false,
	      # format: 'json',
	      # page: 20,
	      # desc: false,
	      # :'photo-host' => 'public',
	      # fields: nil,
	      # sig_id: '6961025',
	      # sig: 'e7c125873db521bf383b3dc0c4e49673ec48c37d'
		}
		


	    meetup_api = MeetupApi.new

	    @events = meetup_api.events(event_options)
	    @member = meetup_api.members(member_options)
	  #   @venue = meetup_api.venues(options)
	  #   if @events["results"].length > 0
		 #    seconds = @events["results"][0]["time"]/1000
			# 	@date = Time.at(seconds).strftime("%m/%d/%Y")
			# end
	end
end

# member = User.find_by(meetup_id: params[:random][:meetup_id])
# @member = member.get_meetup_info(params[:random][:lon], params[:random][lat])
