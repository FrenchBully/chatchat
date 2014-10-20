class ChangingToNewModelNames < ActiveRecord::Migration
  def change
    # remove columns/index in messages
    remove_column :messages, :conversation_id
    add_column :messages, :chat_id, :integer
    add_index :messages, :chat_id 

    # remove column in user
    remove_column :users, :meetup_id

    # add columns to chat users
    add_column :chat_users, :chat_id, :integer
    add_column :chat_users, :user_id, :integer

    # add columns to chats
    add_column :chats, :category, :string
    add_column :chats, :event_id, :integer

    # adds event name to event
    add_column :events, :name, :string
  end
end
