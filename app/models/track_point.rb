# Corresponds to a point in space. Equivalent of a
# GPX <trkpt> element
class TrackPoint < ActiveRecord::Base
  belongs_to :track

  # By default, use the GEOS implementation for spatial columns.
  rgeo_factory_generator = RGeo::Geos.factory_generator

  # But use a geographic implementation for the :lonlat column.
  set_rgeo_factory_for_column(:coordinate, RGeo::Geographic.spherical_factory(:srid => 3756))

  def self.create_from_gpx_track_point(tp, parent_track: parent_track)
    #coordinate = point_factory.point(tp.lon, tp.lat)
    create elevation: tp.elevation, time: tp.time, track: parent_track#, coordinate: coordinate
  end

  def self.point_factory
    RGeo::Geographic.spherical_factory(:srid => 3756)
  end
end
