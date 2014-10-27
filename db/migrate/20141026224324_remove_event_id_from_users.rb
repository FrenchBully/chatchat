class RemoveEventIdFromUsers < ActiveRecord::Migration
  def change
    add_column :users, :meetup_id, :string
  end
end
