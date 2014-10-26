class UsersController < ApplicationController
  before_filter :authenticate_user!
  before_action :get_user, only: [:show, :edit, :update, :save_interest]

  def get_user
    @user = User.find(params[:id])
  end

  def index
    # this is no longer here
    @users = User.all
    @user = current_user
    @event_category = "angularjs"
    @event_id = 1
    # @chat = Chat.find(params[:id])
    # get event.name (@event) and @event.id of chosen event
  end

  def show
    # this is to show user's profile
  	# @user = User.find(params[:id])
    @member = @user.show_user(@user)
  end

  def edit
<<<<<<< HEAD
 
  	@user = User.find(params[:id])
=======

  	# @user = User.find(params[:id])
>>>>>>> 569ec643c1923b9182fec3313d9f24672188a633
    @interests = Interest.all
    @events = @user.get_user_event_list(@user)
    @events_today = @user.get_user_events_today(@events)

    # Redirect to chat room event_path(event_that_was_just_made.id) 
  end

  def update
    
  	@user = User.find(params[:id])
    @selected_events = @user.get_user_event_details(params['event_id'])['results'][0]['name']
    
    if @user.update_attributes(:event_id => params['event_id'], :private_messages => params['user']['private_messages'], :event_name => @selected_events)
      # we need to set this redirect to the main chat room
  	  # @user = User.find(params[:id])
      @user.save
      # we need to set this redirect to the main chat room
      redirect_to edit_user_path(@user)
  	end

  end

  def update_interest
    @user = User.find(params[:id])
    
    @user.update_attributes(:private_messages => params['save_interest']['private_messages'], :lat => params['save_interest']['lat'], :lon => params['save_interest']['lon'] )
    # we need to set this redirect to the main chat room
    edirect_to edit_user_path(@user)
    
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