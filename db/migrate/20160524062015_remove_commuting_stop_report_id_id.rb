class RemoveCommutingStopReportIdId < ActiveRecord::Migration
  def change
    remove_column :commuting_stop_events, :commuting_stop_report_id_id, :integer
  end
end
