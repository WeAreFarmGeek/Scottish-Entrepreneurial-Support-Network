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

ActiveRecord::Schema.define(version: 20140211183427) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "footers", force: true do |t|
    t.string   "image"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
  end

  create_table "graphs", force: true do |t|
    t.string   "setting"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "headers", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.string   "title"
    t.string   "subtitle"
  end

  create_table "organisations", force: true do |t|
    t.string   "name"
    t.text     "blurb"
    t.string   "logo_file_name"
    t.string   "logo_content_type"
    t.integer  "logo_file_size"
    t.datetime "logo_updated_at"
    t.integer  "parent_id"
    t.string   "url"
  end

  create_table "organisations_searches", id: false, force: true do |t|
    t.integer "organisation_id"
    t.integer "search_id"
  end

  create_table "organisations_tags", force: true do |t|
    t.integer "organisation_id"
    t.integer "tag_id"
  end

  create_table "search_types", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "search_types", ["name"], name: "index_search_types_on_name", using: :btree

  create_table "searches", force: true do |t|
    t.integer  "search_type_id"
    t.string   "search"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "searches", ["search_type_id"], name: "index_searches_on_search_type_id", using: :btree

  create_table "tags", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "type"
  end

  create_table "users", force: true do |t|
    t.string   "password_digest"
    t.string   "password_salt"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "email"
  end

end
