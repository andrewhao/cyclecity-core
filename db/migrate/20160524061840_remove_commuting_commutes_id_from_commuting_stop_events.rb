class RemoveCommutingCommutesIdFromCommutingStopEvents < ActiveRecord::Migration
  def change
    remove_column :commuting_stop_events, :commuting_commutes_id, :integer
  end
end
