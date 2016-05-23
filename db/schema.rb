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

ActiveRecord::Schema.define(version: 20160523044412) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "postgis"

  create_table "activities", force: :cascade do |t|
    t.string   "key",        null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "commuting_commutes", force: :cascade do |t|
    t.string   "name"
    t.datetime "started_at"
    t.json     "raw"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "strava_activity_id"
  end

  add_index "commuting_commutes", ["strava_activity_id"], name: "index_commuting_commutes_on_strava_activity_id", using: :btree

  create_table "commuting_stop_events", force: :cascade do |t|
    t.integer   "commuting_stop_report_id_id"
    t.geography "lonlat",                      limit: {:srid=>4326, :type=>"point", :geographic=>true},             null: false
    t.datetime  "stopped_at",                                                                                       null: false
    t.integer   "duration",                                                                             default: 0
  end

  add_index "commuting_stop_events", ["commuting_stop_report_id_id"], name: "index_commuting_stop_events_on_commuting_stop_report_id_id", using: :btree

  create_table "commuting_stop_reports", force: :cascade do |t|
    t.integer "strava_activity_id", null: false
  end

  add_index "commuting_stop_reports", ["strava_activity_id"], name: "index_commuting_stop_reports_on_strava_activity_id", using: :btree

  create_table "track_analytics", force: :cascade do |t|
    t.integer  "track_id"
    t.decimal  "stress_score"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.decimal  "grade_adjusted_pace"
    t.decimal  "average_pace"
  end

  add_index "track_analytics", ["track_id"], name: "index_track_analytics_on_track_id", using: :btree

  create_table "track_points", force: :cascade do |t|
    t.geometry "coordinate", limit: {:srid=>0, :type=>"point"}
    t.decimal  "elevation"
    t.integer  "heart_rate"
    t.datetime "time"
    t.integer  "track_id"
  end

  add_index "track_points", ["coordinate"], name: "index_track_points_on_coordinate", using: :gist
  add_index "track_points", ["track_id"], name: "index_track_points_on_track_id", using: :btree

  create_table "tracks", force: :cascade do |t|
    t.geometry "path",        limit: {:srid=>0, :type=>"multi_line_string"}
    t.string   "title"
    t.text     "description"
    t.integer  "activity_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "recorded_at"
    t.string   "file_uri"
  end

  add_index "tracks", ["path"], name: "index_tracks_on_path", using: :gist

  add_foreign_key "track_analytics", "tracks"
end
