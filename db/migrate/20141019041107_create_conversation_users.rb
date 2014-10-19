class CreateConversationUsers < ActiveRecord::Migration
  def change
    create_table :conversation_users do |t|

      t.timestamps
    end
  end
end
