class RemoveEventIdFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :event_id, :string
    add_column :users, :meetup_id, :string
    remove_column :users, :event_id, :integer
    add_column :users, :event_id, :string
  end
end
