class AddStravaAthleteIdToCommutingCommutes < ActiveRecord::Migration
  def change
    add_column :commuting_commutes, :strava_athlete_id, :int
  end
end
