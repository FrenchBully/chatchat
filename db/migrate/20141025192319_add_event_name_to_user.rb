class AddEventNameToUser < ActiveRecord::Migration
  def change
    add_column :users, :event_name, :string
  end
end
