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

  	# @user = User.find(params[:id])
    @interests = Interest.all
    @events = @user.get_user_event_list(@user)
    @events_today = @user.get_user_events_today(@events)

    # Redirect to chat room event_path(event_that_was_just_made.id) 
  end

  def update
  	# @user = User.find(params[:id])
      if @user.update_attributes(:event_id => params['event_id'], :private_messages => params['user']['private_messages'] )
        @user.save
          # we need to set this redirect to the main chat room
        redirect_to edit_user_path(@user)
  	end
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