class IndexPoints < ActiveRecord::Migration
  def change
    change_table :track_points do |t|
      t.index :coordinate, using: :gist
    end
  end
end
