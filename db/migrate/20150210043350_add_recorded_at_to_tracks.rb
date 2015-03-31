class AddRecordedAtToTracks < ActiveRecord::Migration
  def change
    add_column :tracks, :recorded_at, :datetime
  end
end
