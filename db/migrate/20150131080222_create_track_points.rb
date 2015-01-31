class CreateTrackPoints < ActiveRecord::Migration
  def change
    create_table :track_points do |t|
      t.st_point :coordinate, geographic: true
      t.decimal :elevation, precision: 2
      t.integer :heart_rate, precision: 2
      t.timestamp :time
      t.references :tracks, index: true
    end
  end
end
