class UpdateCommutingStopEventClustersToVersion3 < ActiveRecord::Migration
  def change
    update_view :commuting_stop_event_clusters, version: 3, revert_to_version: 2
  end
end
