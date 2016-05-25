class AddTimestampsOnCommutingStopEvents < ActiveRecord::Migration
  def change
    change_table :commuting_stop_events do |t|
      t.timestamps
    end
  end
end
