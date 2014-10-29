class AddingSubscribeToChatUser < ActiveRecord::Migration
  def change
    add_column :chat_users, :subscribed, :boolean, default: false
  end
end
