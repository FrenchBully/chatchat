class EventsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :belongs_to_event?
  before_action :get_current_users, only: [:show]
  helper_method :get_current_users

  def show

    # on refresh reset to prevent duplicate subscriptions
    current_user.chat_users.each do |chat_user|
      chat_user.subscribed = false
      chat_user.save
    end
    @user = current_user
    # pass these to page
    @event = Event.find(params[:id])
    # these go to startup main chat in erb file to make main chat
    @event_category = "main"
    @event_id = @event.id
    # find main chat so partial header can load with chat info
    @chat = current_user.chats.find_by(event_id: @event.id, category: @event_category)
  end

  def get_current_users
    @users = []
    Chat.find_by(event_id: current_user.event_id, category: "main").users.each do |u|
      @users << u
    end
      return @users
  end

  def belongs_to_event?
    if current_user.event_id.to_s != params[:id]
      redirect_to root_path
    end
  end

  # IN TESTING 
  # def get_users_with_matching_interests(event_id, interest_id)
  #   sql = "Select * from users left outer join interests_users on user_id = users.id left outer join interests on interests.id = interests_users.interest_id where users.event_id = 'dfgklcysnbmc'"
  #   matching_emails = ActiveRecord::Base.connection.execute(sql)

  # end
  
end
  
