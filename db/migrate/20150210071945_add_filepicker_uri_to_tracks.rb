class AddFilepickerUriToTracks < ActiveRecord::Migration
  def change
    add_column :tracks, :file_uri, :string
  end
end
