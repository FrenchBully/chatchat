class CreateInterests < ActiveRecord::Migration
  def change
    create_table :interests do |t|
      t.references :user, index: true
      t.string :name

      t.timestamps
    end
  end
end
