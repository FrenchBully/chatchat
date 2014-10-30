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
	      member_id: @user.uid,
	      # member_id: '6961025',
	      # rsvp: 'yes',
	      # format: 'json',
	      # signed: true,
	      # key: 'd342618183a7f21122ef1b3f2541'
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
	      member_id: @user.uid,
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

	    @events = meetup_api.events(event_options)
	    meetup_api = MeetupApi.new

	    @member = meetup_api.members(member_options)

	end

	def select_location
		@no_events = false
		@user = current_user
	    @events = @user.get_user_event_list(@user)
	    @events_today = @user.get_user_events_today(@events)
	    # binding.pry
		# case @events_today
		if @events_today.length == 0
			@no_events = true
			# the user has no events today"
			# destroy_user_session_path
			flash[:notice] = "Yikes! You don't have any upcoming Meetup events."
			# sign_out_and_redirect(root_path)
		elsif @events_today.length == 1
			 current_user.chat_users.destroy_all

	    # get event details of selected event
	    # find existing or create event with id from meetups api and selected event
	    event = Event.find_or_create_by(meetup_event_id: @events_today[0][:id], name: @events_today[0][:name])
	    # make the main default chatroom for this event here
	    chat = Chat.find_or_create_by(category: "main", event_id: event.id)

	    ChatUser.find_or_create_by(chat_id: chat.id, user_id: current_user.id)
  	if @user.update_attributes(event_id: event.id, event_name: event.name)
      # send to edit profile page
      redirect_to edit_user_path(@user)
  	end

		elsif @events_today.length > 1
			# stay here
		end
		
	end
end

# member = User.find_by(meetup_id: params[:random][:meetup_id])
# @member = member.get_meetup_info(params[:random][:lon], params[:random][lat])
