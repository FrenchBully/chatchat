class ChangeTableColumnsForModelNames < ActiveRecord::Migration
  def change

    # SWITCH TO NEW MODEL NAMES

    # dropping model tables
    drop_table :conversation_users
    drop_table :conversations
    drop_table :meetups
  end
end
