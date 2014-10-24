class RemoveUserIdFromInterests < ActiveRecord::Migration
  def change
    remove_column :interests, :user_id, :string
  end
end
