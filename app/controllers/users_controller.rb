class UsersController < ApplicationController
  before_filter :authenticate_user!


  def index
    @users = User.all
    @user = current_user

    # get event.name (@event) and @event.id of chosen event

  end

  def show
  	@user = User.find(params[:id])
    # this next line could be named better--to not confuse the two 'params'
    params = { 
        member_id: @user.uid,
    }
      meetup_api = MeetupApi.new

      @member = meetup_api.members(params)
  end

  def edit
  	@user = User.find(params[:id])
    @interests = Interest.all

    options = { 
        member_id: @user.uid,
        time: "0d,1d"
    }

    meetup_api = MeetupApi.new

    @events = meetup_api.events(options)
    @events_today = []
    i = 0

    while i < @events["results"].length 

      if Time.at(@events["results"][i]["time"]/ 1000) - Time.now < 12.hours
        
        @events_today << {
        :name => @events["results"][i]["name"],
        :id => @events["results"][i]["id"],
        :time => Time.at(@events["results"][i]["time"] / 1000)
        }
      end
      i += 1
    end
    
  end

  def update
  	@user = User.find(params[:id])
  	if @user.update_attributes(:event_id => params['event_id'], :private_messages => params['user']['private_messages'] ) 
  		@user.save
      redirect_to root_path
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