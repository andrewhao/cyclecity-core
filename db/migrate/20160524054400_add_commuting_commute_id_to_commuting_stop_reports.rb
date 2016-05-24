class AddCommutingCommuteIdToCommutingStopReports < ActiveRecord::Migration
  def change
    add_reference :commuting_stop_reports, :commuting_commute, index: true, foreign_key: true
  end
end
