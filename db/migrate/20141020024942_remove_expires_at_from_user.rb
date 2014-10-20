class RemoveExpiresAtFromUser < ActiveRecord::Migration
  def change
    remove_column :users, :expires_at, :datetime
    add_column :users, :expires_at, :integer
  end
end
