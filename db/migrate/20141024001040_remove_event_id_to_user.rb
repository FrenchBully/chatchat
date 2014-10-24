class RemoveEventIdToUser < ActiveRecord::Migration
  def change
    remove_column :users, :event_id, :integer
    add_column :users, :event_id, :string
  end
end
