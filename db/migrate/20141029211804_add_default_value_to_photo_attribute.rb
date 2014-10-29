class AddDefaultValueToPhotoAttribute < ActiveRecord::Migration
  def change
  	change_column :users, :photo, :string, :default => 'http://blog.ramboll.com/fehmarnbelt/wp-content/themes/ramboll2/images/profile-img.jpg'
  end
end
