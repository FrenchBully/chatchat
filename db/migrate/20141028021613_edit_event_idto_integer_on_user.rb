class EditEventIdtoIntegerOnUser < ActiveRecord::Migration
  def change
    remove_column :users, :event_id, :string
    add_column :users, :event_id, :integer
  end
end
