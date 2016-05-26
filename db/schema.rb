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

ActiveRecord::Schema.define(version: 20160526064302) do

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

  create_view :geography_columns,  sql_definition: <<-SQL
      SELECT current_database() AS f_table_catalog,
      n.nspname AS f_table_schema,
      c.relname AS f_table_name,
      a.attname AS f_geography_column,
      postgis_typmod_dims(a.atttypmod) AS coord_dimension,
      postgis_typmod_srid(a.atttypmod) AS srid,
      postgis_typmod_type(a.atttypmod) AS type
     FROM pg_class c,
      pg_attribute a,
      pg_type t,
      pg_namespace n
    WHERE ((t.typname = 'geography'::name) AND (a.attisdropped = false) AND (a.atttypid = t.oid) AND (a.attrelid = c.oid) AND (c.relnamespace = n.oid) AND (NOT pg_is_other_temp_schema(c.relnamespace)) AND has_table_privilege(c.oid, 'SELECT'::text));
  SQL

  create_view :raster_columns,  sql_definition: <<-SQL
      SELECT current_database() AS r_table_catalog,
      n.nspname AS r_table_schema,
      c.relname AS r_table_name,
      a.attname AS r_raster_column,
      COALESCE(_raster_constraint_info_srid(n.nspname, c.relname, a.attname), ( SELECT st_srid('010100000000000000000000000000000000000000'::geometry) AS st_srid)) AS srid,
      _raster_constraint_info_scale(n.nspname, c.relname, a.attname, 'x'::bpchar) AS scale_x,
      _raster_constraint_info_scale(n.nspname, c.relname, a.attname, 'y'::bpchar) AS scale_y,
      _raster_constraint_info_blocksize(n.nspname, c.relname, a.attname, 'width'::text) AS blocksize_x,
      _raster_constraint_info_blocksize(n.nspname, c.relname, a.attname, 'height'::text) AS blocksize_y,
      COALESCE(_raster_constraint_info_alignment(n.nspname, c.relname, a.attname), false) AS same_alignment,
      COALESCE(_raster_constraint_info_regular_blocking(n.nspname, c.relname, a.attname), false) AS regular_blocking,
      _raster_constraint_info_num_bands(n.nspname, c.relname, a.attname) AS num_bands,
      _raster_constraint_info_pixel_types(n.nspname, c.relname, a.attname) AS pixel_types,
      _raster_constraint_info_nodata_values(n.nspname, c.relname, a.attname) AS nodata_values,
      _raster_constraint_info_out_db(n.nspname, c.relname, a.attname) AS out_db,
      _raster_constraint_info_extent(n.nspname, c.relname, a.attname) AS extent,
      COALESCE(_raster_constraint_info_index(n.nspname, c.relname, a.attname), false) AS spatial_index
     FROM pg_class c,
      pg_attribute a,
      pg_type t,
      pg_namespace n
    WHERE ((t.typname = 'raster'::name) AND (a.attisdropped = false) AND (a.atttypid = t.oid) AND (a.attrelid = c.oid) AND (c.relnamespace = n.oid) AND ((c.relkind)::text = ANY ((ARRAY['r'::character(1), 'v'::character(1), 'm'::character(1), 'f'::character(1)])::text[])) AND (NOT pg_is_other_temp_schema(c.relnamespace)) AND has_table_privilege(c.oid, 'SELECT'::text));
  SQL

  create_view :raster_overviews,  sql_definition: <<-SQL
      SELECT current_database() AS o_table_catalog,
      n.nspname AS o_table_schema,
      c.relname AS o_table_name,
      a.attname AS o_raster_column,
      current_database() AS r_table_catalog,
      (split_part(split_part(s.consrc, '''::name'::text, 1), ''''::text, 2))::name AS r_table_schema,
      (split_part(split_part(s.consrc, '''::name'::text, 2), ''''::text, 2))::name AS r_table_name,
      (split_part(split_part(s.consrc, '''::name'::text, 3), ''''::text, 2))::name AS r_raster_column,
      (btrim(split_part(s.consrc, ','::text, 2)))::integer AS overview_factor
     FROM pg_class c,
      pg_attribute a,
      pg_type t,
      pg_namespace n,
      pg_constraint s
    WHERE ((t.typname = 'raster'::name) AND (a.attisdropped = false) AND (a.atttypid = t.oid) AND (a.attrelid = c.oid) AND (c.relnamespace = n.oid) AND ((c.relkind)::text = ANY ((ARRAY['r'::character(1), 'v'::character(1), 'm'::character(1), 'f'::character(1)])::text[])) AND (s.connamespace = n.oid) AND (s.conrelid = c.oid) AND (s.consrc ~~ '%_overview_constraint(%'::text) AND (NOT pg_is_other_temp_schema(c.relnamespace)) AND has_table_privilege(c.oid, 'SELECT'::text));
  SQL

  create_view :commuting_stop_event_clusters,  sql_definition: <<-SQL
      SELECT row_number() OVER () AS id,
      st_numgeometries(f.gc) AS st_numgeometries,
      f.gc AS geom_collection,
      st_centroid(f.gc) AS centroid,
      st_minimumboundingcircle(f.gc) AS circle,
      sqrt((st_area(st_minimumboundingcircle(f.gc)) / pi())) AS radius
     FROM ( SELECT unnest(st_clusterwithin((c.lonlat)::geometry, (st_distance(st_geomfromtext('POINT(34.0151661 -118.49075029)'::text, 4326), st_geomfromtext('POINT(34.0153382 -118.4901983)'::text, 4326)) / (10)::double precision))) AS gc
             FROM commuting_stop_events c) f;
  SQL

end
