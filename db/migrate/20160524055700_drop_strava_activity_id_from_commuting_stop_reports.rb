class DropStravaActivityIdFromCommutingStopReports < ActiveRecord::Migration
  def change
    remove_column :commuting_stop_reports, :strava_activity_id
  end
end
