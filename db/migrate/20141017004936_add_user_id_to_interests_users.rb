class AddUserIdToInterestsUsers < ActiveRecord::Migration
  def change
    add_column :interests_users, :User_id, :integer
  end
end
