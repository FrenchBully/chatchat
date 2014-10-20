class AddInterestIdToInterestsUsers < ActiveRecord::Migration
  def change
    add_column :interests_users, :interest_id, :integer
  end
end
