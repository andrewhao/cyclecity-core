class IndexTracks < ActiveRecord::Migration
  def change
    change_table :tracks do |t|
      t.index :path, spatial: true
    end
  end
end
