class Event < ActiveRecord::Base
  has_many :chats
  has_one :user
  
end
