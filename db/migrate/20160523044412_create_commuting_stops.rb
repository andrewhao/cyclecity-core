class CreateCommutingStops < ActiveRecord::Migration
  def change
    create_table :commuting_stop_reports do |t|
      t.integer :strava_activity_id, null: false
      t.index :strava_activity_id
    end

    create_table :commuting_stop_events do |t|
      t.references :commuting_stop_report_id, index: true
      t.st_point :lonlat, geographic: true, null: false
      t.datetime :stopped_at, null: false
      t.integer :duration, default: 0
    end
  end
end
