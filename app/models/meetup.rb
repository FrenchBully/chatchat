class Meetup < ActiveRecord::Base
  has_many :conversations
end
