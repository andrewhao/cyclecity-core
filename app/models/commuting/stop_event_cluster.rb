module Commuting
  class StopEventCluster < ActiveRecord::Base
    self.table_name = 'commuting_stop_event_clusters'

    def self.query
      selects = <<-SQL
  row_number() over () AS id,
  ST_NumGeometries(gc) AS cluster_count,
  gc AS geom_collection,
  ST_Centroid(gc) AS centroid,
  ST_MinimumBoundingCircle(gc) AS circle,
  sqrt(ST_Area(ST_MinimumBoundingCircle(gc)) / pi()) AS radius
SQL

    nested_clusters = <<-SQL
	(SELECT unnest(ST_ClusterWithin(
			c.lonlat::geometry,
			-- 6.3m or so
			ST_Distance( ST_GeomFromText('POINT(34.0151661 -118.49075029)', 4326), ST_GeomFromText('POINT(34.0153382 -118.4901983)', 4326) ) / 10
	)) gc
  FROM commuting_stop_events c) f
  SQL
      query = select(selects).from(nested_clusters)
      ap query.to_sql
      query
    end

    def as_json(attrs={})
      c = RGeo::GeoJSON.encode(centroid)
      cir = RGeo::GeoJSON.encode(circle)
      gc = RGeo::GeoJSON.encode(geom_collection)
      { id: id, centroid: c, circle: cir, radius: radius, geom_collection: gc }
    end
  end
end
