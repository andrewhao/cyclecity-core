# Corresponds to a point on a geographical space. Corresponding concept to the
# GPX <trkpt> element
class TrackPoint < ActiveRecord::Base
  # By default, use the GEOS implementation for spatial columns.
  rgeo_factory_generator = RGeo::Geos.factory_generator

  # But use a geographic implementation for the :lonlat column.
  set_rgeo_factory_for_column(:coordinate, RGeo::Geographic.spherical_factory(:srid => 3756))
end
