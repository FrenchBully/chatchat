class Chat < ActiveRecord::Base
  has_many :messages, dependent: :destroy
  belongs_to :event

  has_many :chat_users
  has_many :users, through: :chat_users

  def self.existing_chat(event_id, category)
    Chat.find_by(event_id: event_id, category: category)
  end

end
