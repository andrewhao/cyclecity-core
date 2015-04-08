# Corresponds to a point on a geographical space. Corresponding concept to the
# GPX <trkpt> element
class TrackPoint < ActiveRecord::Base
  belongs_to :track

  # But use a geographic implementation for the :coordinate column.
  set_rgeo_factory_for_column(:coordinate, point_factory)

  def self.create_from_gpx_track_point(tp, parent_track: parent_track)
    Rails.logger.info "TrackPoint from GPX is: lon-#{tp.lon} and lat-#{tp.lat}."
    coordinate = point_factory.point(tp.lon, tp.lat)
    Rails.logger.info "point_factory is: #{point_factory.inspect}"
    Rails.logger.info "coordinate is: #{coordinate.inspect}"
    create coordinate: coordinate
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
