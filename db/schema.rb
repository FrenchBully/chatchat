# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20141029212851) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "chat_users", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "chat_id"
    t.integer  "user_id"
    t.boolean  "subscribed", default: false
  end

  create_table "chats", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "category"
    t.integer  "event_id"
  end

  create_table "events", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.string   "meetup_event_id"
  end

  create_table "interests", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "interests_users", force: true do |t|
    t.integer "user_id"
    t.integer "interest_id"
  end

  create_table "messages", force: true do |t|
    t.text     "body"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "chat_id"
  end

  add_index "messages", ["chat_id"], name: "index_messages_on_chat_id", using: :btree
  add_index "messages", ["user_id"], name: "index_messages_on_user_id", using: :btree

  create_table "user_providers", force: true do |t|
    t.integer  "user_id"
    t.string   "provider"
    t.string   "uid"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "user_providers", ["user_id"], name: "index_user_providers_on_user_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "email",                  default: "",                                                                                      null: false
    t.string   "encrypted_password",     default: "",                                                                                      null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,                                                                                       null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "provider"
    t.string   "auth_token"
    t.string   "uid"
    t.float    "lat"
    t.float    "lon"
    t.string   "name"
    t.string   "photo",                  default: "http://blog.ramboll.com/fehmarnbelt/wp-content/themes/ramboll2/images/profile-img.jpg"
    t.boolean  "private_messages",       default: true
    t.text     "bio"
    t.string   "refresh_token"
    t.string   "location"
    t.integer  "expires_at"
    t.string   "event_name"
    t.string   "meetup_id"
    t.integer  "event_id"
    t.string   "phone"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
