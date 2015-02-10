class CreateTrackAnalytics < ActiveRecord::Migration
  def change
    create_table :track_analytics do |t|
      t.references :track, index: true
      t.integer :stress_score

      t.timestamps null: false
    end
    add_foreign_key :track_analytics, :tracks
  end
end
