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

ActiveRecord::Schema.define(version: 20150131081652) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "postgis"

  create_table "track_points", force: :cascade do |t|
    t.st_point "coordinate", :geographic=>true
    t.decimal   "elevation",                                                           precision: 2
    t.integer   "heart_rate"
    t.datetime  "time"
    t.integer   "tracks_id"
  end

  add_index "track_points", ["coordinate"], name: "index_track_points_on_coordinate", spatial: true
  add_index "track_points", ["tracks_id"], name: "index_track_points_on_tracks_id"

  create_table "tracks", force: :cascade do |t|
    t.multi_line_string "path"
    t.string   "title"
    t.text     "description"
    t.integer  "activity_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "tracks", ["path"], name: "index_tracks_on_path", spatial: true

end
