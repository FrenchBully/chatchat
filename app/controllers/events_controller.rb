class EventsController < ApplicationController
before_filter :authenticate_user!
# before_filter :belongs_to_event?


  def show
    # from event_path(event.id) or '/events/:id'
    @event_category = "angularjs"
    @event_id = 1

    # get_users_with_matching_interests("dcmvrhysnbkc", "ice cream")
    # this is where the chat room is and where it gets setup
  end

  def belongs_to_event?
    # check user to see if he belongs to event
    # redirect_to '/'
  end

  def get_users_with_matching_interests(event_id, interest_id)
    sql = "Select * from users left outer join interests_users on user_id = users.id left outer join interests on interests.id = interests_users.interest_id where users.event_id = 'dcmvrhysnbkc'"
    matching_emails = ActiveRecord::Base.connection.execute(sql)
    binding.pry
  end
end
