class AddCommutingCommutesIdToCommutingStopEvents < ActiveRecord::Migration
  def change
    add_column :commuting_stop_events, :commuting_commute_id, :integer
    add_reference :commuting_stop_events, :commuting_commutes, index: true, foreign_key: true
  end
end
