class UsersController < ApplicationController
  before_filter :authenticate_user!


  def index
    # this is no longer here
    @users = User.all
    @user = current_user
    @event_category = "angularjs"
    @event_id = 1
    # get event.name (@event) and @event.id of chosen event
  end

  def show
    # this is to show user's profile
  	@user = User.find(params[:id])
    @member = @user.show_user(@user)
  end

  def edit

  	@user = User.find(params[:id])
    @interests = Interest.all
    @events = @user.get_user_event_list(@user)
    @events_today = @user.get_user_events_today(@events)
    

    # Redirect to chat room event_path(event_that_was_just_made.id) 
  end

  def update
    binding.pry

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