class UsersController < ApplicationController
  before_filter :authenticate_user!
  before_action :get_user, only: [:show, :edit, :update, :save_interest, :update_interest]

  def get_user
    @user = User.find(params[:id])
  end

  def index
    @users = User.all
    @user = current_user
  end

  def show
    # this is to show user's profile
  	# @user = User.find(params[:id])
    @member = @user.show_user(@user)

    # response = HTTParty.get("https://api.meetup.com/2/member_id=#{@user.uid}?&sign=access_token=#{@user.auth_token}")
  end

  def edit
  	# @user = User.find(params[:id])
    @interests = Interest.all
    @events = @user.get_user_event_list(@user)
    @events_today = @user.get_user_events_today(@events)

    # Redirect to chat room event_path(event_that_was_just_made.id) 
  end

  def update

    # get event details of selected event
    @selected_events = @user.get_user_event_details(params['event_id'])['results'][0]['name']
    # find existing or create event with id from meetups api and selected event
    event = Event.find_or_create_by(meetup_event_id: params[:event_id], name: @selected_events)
    # make the main default chatroom for this event here
    chat = Chat.find_or_create_by(category: "main", event_id: event.id)

    x = ChatUser.find_or_create_by(chat_id: chat.id, user_id: current_user.id)
    binding.pry

    # update user profile
    if @user.update_attributes(event_id: event.id, :event_name => @selected_events)
      # send to edit profile page
      redirect_to edit_user_path(@user)
  	end

  end

  def update_interest
    # @user = User.find(params[:id])
    
    @user.update_attributes(:private_messages => params['update_interest']['private_messages'], :lat => params['update_interest']['lat'], :lon => params['update_interest']['lon'] )
    # we need to set this redirect to the main chat room
    # redirect_to edit_user_path(@user)
    redirect_to event_path(@user.event_id)
    
  end

  def save_interest
      # if it doesnt exist
      new_interest = Interest.find_or_create_by(:name => params[:interest])
      # else find it by name and add it

    @user.interests << new_interest
    # @user.event_id
    respond_to do |format|
     format.json { render json: new_interest }
    end

  end

end