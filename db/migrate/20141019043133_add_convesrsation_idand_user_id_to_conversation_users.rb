class AddConvesrsationIdandUserIdToConversationUsers < ActiveRecord::Migration
  def change
    add_column :conversation_users, :conversation_id, :integer
    add_column :conversation_users, :user_id, :integer
  end
end
