class RemoveEventIdFromInterestsUsers < ActiveRecord::Migration
  def change
    remove_column :interests_users, :event_id, :string
  end
end
