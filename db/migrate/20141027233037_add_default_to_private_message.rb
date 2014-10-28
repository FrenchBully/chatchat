class AddDefaultToPrivateMessage < ActiveRecord::Migration
  def change
    change_column :users, :private_messages, :boolean, default: true
  end
end
