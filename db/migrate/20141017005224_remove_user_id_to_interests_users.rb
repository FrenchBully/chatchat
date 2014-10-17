class RemoveUserIdToInterestsUsers < ActiveRecord::Migration
  def change
    remove_column :interests_users, :User_id, :integer
    add_column :interests_users, :user_id, :integer
  end
end
