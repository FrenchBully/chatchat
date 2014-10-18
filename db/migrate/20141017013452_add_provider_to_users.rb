class AddProviderToUsers < ActiveRecord::Migration
  def change
    add_column :users, :provider, :string
    add_column :users, :auth_token, :string
  end
end
