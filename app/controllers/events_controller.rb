class EventsController < ApplicationController
before_filter :authenticate_user!
# before_filter :belongs_to_event?
before_action :get_current_users, only: [:show]
helper_method :get_current_users


# before_action :get_user, only: [:show, :edit, :update, :save_interest]

#   def get_user
#     @user = User.find(params[:id])
#   end

  def show
    @user = current_user

    # pass these to page
    @event = Event.find(params[:id])
    # these go to startup main chat in erb file to make main chat
    @event_category = "main"
    @event_id = @event.id


    # find main chat so partial header can load with chat info
    @chat = current_user.chats.find_by(event_id: @event.id, category: @event_category)
    
    # binding.pry
    # event_id needs updated to @user.event_id once all the pieces are in place
    # gets all of users active chatrooms for this event

    # get_users_with_matching_interests("dcmvrhysnbkc", "ice cream")
    # this is where the chat room is and where it gets setup

    
  end

  def get_current_users
    @users = []
    Chat.find_by(event_id: current_user.event_id, category: "main").users.each do |u|
      @users << u
    end
      return @users
  end

  def belongs_to_event?
    # check user to see if he belongs to event
    # redirect_to root_path
  end

  def get_users_with_matching_interests(event_id, interest_id)
    sql = "Select * from users left outer join interests_users on user_id = users.id left outer join interests on interests.id = interests_users.interest_id where users.event_id = 'dcmvrhysnbkc'"
    matching_emails = ActiveRecord::Base.connection.execute(sql)

  end
end
