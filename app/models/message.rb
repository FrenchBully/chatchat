class Message < ActiveRecord::Base
  belongs_to :chat
  belongs_to :user

  validates_presence_of :body, :chat_id, :user_id

  def find_hash_tags
  
  end
end
