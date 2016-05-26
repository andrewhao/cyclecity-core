class CreateCommutingStopEventClusters < ActiveRecord::Migration
  def change
    create_view :commuting_stop_event_clusters
  end
end
