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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20121221193008) do

  create_table "addresses", :force => true do |t|
    t.integer  "warrior_id"
    t.string   "addr_1"
    t.string   "addr_2"
    t.string   "city"
    t.string   "pin_code"
    t.string   "country"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "admins", :force => true do |t|
    t.string   "username",                              :default => "", :null => false
    t.string   "encrypted_password",     :limit => 128, :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                         :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                                            :null => false
    t.datetime "updated_at",                                            :null => false
  end

  add_index "admins", ["reset_password_token"], :name => "index_admins_on_reset_password_token", :unique => true
  add_index "admins", ["username"], :name => "index_admins_on_email", :unique => true

  create_table "cabins", :force => true do |t|
    t.string   "cabin_no"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "district"
    t.string   "state"
    t.boolean  "vacant"
  end

  create_table "feedbacks", :force => true do |t|
    t.integer  "session_id"
    t.text     "feedback"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "regions", :force => true do |t|
    t.string   "name"
    t.string   "code",        :limit => 3
    t.integer  "count"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
    t.string   "region_type", :limit => 15
    t.integer  "last_id"
  end

  add_index "regions", ["code"], :name => "index_regions_on_code"
  add_index "regions", ["name"], :name => "index_regions_on_name"

  create_table "sessions", :force => true do |t|
    t.integer  "warrior_id"
    t.integer  "cabin_id"
    t.datetime "start"
    t.datetime "end"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.float    "total"
  end

  add_index "sessions", ["start"], :name => "index_sessions_on_start"
  add_index "sessions", ["warrior_id"], :name => "index_sessions_on_warrior_id"

  create_table "warriors", :force => true do |t|
    t.string   "name"
    t.string   "church"
    t.string   "phone"
    t.string   "referrer"
    t.string   "warrior_no"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "region_id"
    t.integer  "commitment"
  end

  add_index "warriors", ["commitment"], :name => "index_warriors_on_commitment"
  add_index "warriors", ["name"], :name => "index_warriors_on_name"
  add_index "warriors", ["region_id"], :name => "index_warriors_on_region_id"

end
