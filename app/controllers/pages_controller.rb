class PagesController < ApplicationController
  	require 'meetup_client'
  	require 'json'

	def index
	end

	def welcome
		@user = current_user
		if !@user
			redirect_to new_user_session_path
		end
	end

	# allows the user to select location of event
	def select_location
		@no_events = false
		@user = current_user
	    @events = @user.get_user_event_list(@user)
	    @events_today = @user.get_user_events_today(@events)

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
