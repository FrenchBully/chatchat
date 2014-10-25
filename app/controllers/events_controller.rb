class EventsController < ApplicationController
before_filter :authenticate_user!
# before_filter :belongs_to_event?


  def show
    # from event_path(event.id) or '/events/:id'
    @event_category = "angularjs"
    @event_id = 1
    # this is where the chat room is and where it gets setup
  end

  def belongs_to_event?
    # check user to see if he belongs to event
    # redirect_to '/'
  end
end
