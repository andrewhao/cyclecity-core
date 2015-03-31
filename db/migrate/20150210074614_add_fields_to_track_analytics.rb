class AddFieldsToTrackAnalytics < ActiveRecord::Migration
  def change
    add_column :track_analytics, :grade_adjusted_pace, :decimal
    add_column :track_analytics, :average_pace, :decimal
    change_column :track_analytics, :stress_score, :decimal
  end
end
