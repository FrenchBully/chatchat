class Event < ActiveRecord::Base
  has_many :chats
  has_many :users
  
end
