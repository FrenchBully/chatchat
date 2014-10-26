class RemoveEventIdFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :event_id, :string
  end
end
