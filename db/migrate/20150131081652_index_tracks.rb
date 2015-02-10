class IndexTracks < ActiveRecord::Migration
  def change
    change_table :tracks do |t|
      t.index :path, using: :gist
    end
  end
end
