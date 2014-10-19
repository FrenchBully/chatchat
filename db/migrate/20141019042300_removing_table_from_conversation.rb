class RemovingTableFromConversation < ActiveRecord::Migration
  def change
    remove_column :conversations, :sender_id
    remove_column :conversations, :recipient_id

    add_column :conversations, :category, :string
    add_column :conversations, :meetup_id, :integer
  end
end
