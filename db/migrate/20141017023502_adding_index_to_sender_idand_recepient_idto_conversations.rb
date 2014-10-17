class AddingIndexToSenderIdandRecepientIdtoConversations < ActiveRecord::Migration
  def change
    add_index :conversations, :sender_id
    add_index :conversations, :recipient_id
  end
end
