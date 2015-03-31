class RenameTracksIdColumn < ActiveRecord::Migration
  def change
    rename_column :track_points, :tracks_id, :track_id
  end
end
