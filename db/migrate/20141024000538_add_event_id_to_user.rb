class AddEventIdToUser < ActiveRecord::Migration
  def change
    add_column :users, :event_id, :integer

  end
end
