class AddStravaActivityIdToCommutingCommuters < ActiveRecord::Migration
  def change
    add_column :commuting_commutes, :strava_activity_id, :integer
    add_index :commuting_commutes, :strava_activity_id
  end
end
