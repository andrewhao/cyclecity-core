class AddSpatialIndexToCommutingStopEvents < ActiveRecord::Migration
  def change
    add_index :commuting_stop_events, :lonlat, using: :gist
  end
end
