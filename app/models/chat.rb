class Chat < ActiveRecord::Base
  has_many :messages, dependent: :destroy
  belongs_to :event

  has_many :chat_users
  has_many :users, through: :chat_users

  def self.existing_chat(event_id, category)
    Chat.find_by(event_id: event_id, category: category)
  end

  # def get_current_users
  #   users = []
  #   chat = Chat.find_by(event_id: @user.event_id)
  #   chat.users.each do |u| 
  #     users << u.name
  #   end
  #   return users
  # end

end


 # validates_uniqueness_of :sender_id, :scope => :recipient_id
 
  # scope :involving, -> (user) do
  #   where("chat.sender_id =? OR chat.recipient_id =?",user.id,user.id)
  # end
 
  # scope :between, -> (sender_id,recipient_id) do
  #   where("(chat.sender_id = ? AND chat.recipient_id =?) OR (chat.sender_id = ? AND chat.recipient_id =?)", sender_id,recipient_id, recipient_id, sender_id)
  # end