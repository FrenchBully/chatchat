class AddEventIdToInterestsUsers < ActiveRecord::Migration
  def change
    add_column :interests_users, :event_id, :integer
  end
end
