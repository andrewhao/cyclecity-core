class CreateTrackPoints < ActiveRecord::Migration
  def change
    create_table :track_points do |t|
      t.point :coordinate, geographic: true, srid: 3785
      t.decimal :elevation, precision: 2
      t.integer :heart_rate, precision: 2
      t.timestamp :time
      t.references :tracks, index: true
    end
  end
end
