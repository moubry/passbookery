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

ActiveRecord::Schema.define(:version => 20121012202250) do

  create_table "logs", :force => true do |t|
    t.text     "message"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "passes", :force => true do |t|
    t.string   "pass_type_identifier"
    t.string   "serial_number"
    t.hstore   "data"
    t.datetime "created_at",           :null => false
    t.datetime "updated_at",           :null => false
    t.string   "authentication_token"
  end

  add_index "passes", ["pass_type_identifier", "serial_number"], :name => "index_passes_on_pass_type_identifier_and_serial_number"

  create_table "registrations", :force => true do |t|
    t.integer  "pass_id"
    t.string   "device_library_identifier"
    t.string   "push_token"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  add_index "registrations", ["device_library_identifier"], :name => "index_registrations_on_device_library_identifier"

end
