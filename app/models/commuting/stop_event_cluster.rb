module Commuting
  class StopEventCluster < ActiveRecord::Base
    self.table_name = 'commuting_stop_event_clusters'

    def as_json(attrs={})
      c = RGeo::GeoJSON.encode(centroid)
      cir = RGeo::GeoJSON.encode(circle)
      gc = RGeo::GeoJSON.encode(geom_collection)
      { id: id, centroid: c, circle: cir, radius: radius, geom_collection: gc }
    end
  end
end
