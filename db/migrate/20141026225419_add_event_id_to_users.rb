class AddEventIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :event_id, :string
  end
end
