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

ActiveRecord::Schema.define(version: 20160620184738) do

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
    t.geography "lonlat",               limit: {:srid=>4326, :type=>"point", :geographic=>true},             null: false
    t.datetime  "stopped_at",                                                                                null: false
    t.integer   "duration",                                                                      default: 0
    t.integer   "commuting_commute_id"
    t.datetime  "created_at"
    t.datetime  "updated_at"
  end

  add_index "commuting_stop_events", ["lonlat"], name: "index_commuting_stop_events_on_lonlat", using: :gist

  create_table "commuting_stop_reports", force: :cascade do |t|
    t.integer "commuting_commute_id"
  end

  add_index "commuting_stop_reports", ["commuting_commute_id"], name: "index_commuting_stop_reports_on_commuting_commute_id", using: :btree

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

  add_foreign_key "commuting_stop_events", "commuting_commutes"
  add_foreign_key "commuting_stop_reports", "commuting_commutes"
  add_foreign_key "track_analytics", "tracks"

  create_view :commuting_stop_event_clusters,  sql_definition: <<-SQL
      SELECT row_number() OVER () AS id,
      st_numgeometries(f.gc) AS cluster_count,
      f.gc AS geom_collection,
      st_centroid(f.gc) AS centroid,
      st_minimumboundingcircle(f.gc) AS circle,
      sqrt((st_area(st_minimumboundingcircle(f.gc)) / pi())) AS radius
     FROM ( SELECT unnest(st_clusterwithin((c.lonlat)::geometry, (st_distance(st_geomfromtext('POINT(34.0151661 -118.49075029)'::text, 4326), st_geomfromtext('POINT(34.0153382 -118.4901983)'::text, 4326)) / (10)::double precision))) AS gc
             FROM commuting_stop_events c) f;
  SQL

end
