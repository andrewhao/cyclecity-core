# Corresponds to a point on a geographical space. Corresponding concept to the
# GPX <trkpt> element
class TrackPoint < ActiveRecord::Base
  belongs_to :track

  def self.create_from_gpx_track_point(tp, parent_track: parent_track)
    coordinate = point_factory.point(tp.lon, tp.lat)
    create elevation: tp.elevation, time: tp.time, track: parent_track, coordinate: coordinate
  end

  def latitude
    coordinate.y
  end

  def longitude
    coordinate.x
  end

  def self.point_factory
    RGeo::Geographic.spherical_factory(:srid => 4326)
  end
end
