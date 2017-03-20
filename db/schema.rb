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

ActiveRecord::Schema.define(version: 20170320034423) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "daily_notifications", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "prayer_slot_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "daily_notifications", ["prayer_slot_id"], name: "index_daily_notifications_on_prayer_slot_id", using: :btree

  create_table "prayer_slots", force: :cascade do |t|
    t.integer  "user_id"
    t.datetime "due"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "prayer_slots", ["due"], name: "index_prayer_slots_on_due", using: :btree
  add_index "prayer_slots", ["user_id", "due"], name: "index_prayer_slots_on_user_id_and_due", unique: true, using: :btree
  add_index "prayer_slots", ["user_id"], name: "index_prayer_slots_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "time_zone"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
