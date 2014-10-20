class AddPrivateMessagesToUsers < ActiveRecord::Migration
  def change
    add_column :users, :private_messages, :boolean
  end
end
