class AddMeetupNumbertoMeetup < ActiveRecord::Migration
  def change
    add_column :meetups, :meetup_name, :string
  end
end
