class UsersController < ApplicationController
  before_filter :authenticate_user!


  def index
    @users = User.all
    @user = current_user
    # get event.name (@event) and @event.id of chosen event
  end

  def show
    # this is to show user's profile
  	@user = User.find(params[:id])
    @member = @user.show_user(@user)
  end

  def edit
    # MeetupClient.configure do |config|
    # # Ran's => config.api_key = 'b7d767765272d2b2b13c25e744e13'
    #   config.api_key = ''
    # end
  	@user = User.find(params[:id])
    @interests = Interest.all
    @events = @user.get_user_event_list(@user)
    @events_today = @user.get_user_events_today(@events)
    

    # Redirect to chat room event_path(event_that_was_just_made.id) 
  end

  def update
  	@user = User.find(params[:id])
  	if @user.update_attributes(:event_id => params['event_id'], :private_messages => params['user']['private_messages'] ) 
  		@user.save
      # we need to set this redirect to the main chat room
      redirect_to user_path(@user)
  	else
  		render 'edit'
  	end

  end

  def save_interest
    @user = current_user
    new_interest = Interest.create(:name => params[:interest])
    @user.interests << new_interest
    respond_to do |format|
     format.json { render json: new_interest }
    end
  end

  # def remove_interest
  #   @user = current_user
  #   @user.interests.delete(:name => params[:interest])
  #   render nothing: true
  # end

end