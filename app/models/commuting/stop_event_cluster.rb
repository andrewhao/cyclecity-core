module Commuting
  class StopEventCluster < ActiveRecord::Base
    self.table_name = 'commuting_stop_event_clusters'

    def self.query
      selects = <<-SQL
  row_number() over () AS id,
	2 as total_wait_time,
  AVG(cse.duration) as average_stop_duration,
  ST_NumGeometries(sc.cluster) AS cluster_count,
  sc.cluster AS geom_collection,
  ST_Centroid(sc.cluster) AS centroid,
  ST_MinimumBoundingCircle(sc.cluster) AS circle,
  sqrt(ST_Area(ST_MinimumBoundingCircle(sc.cluster)) / pi()) AS radius
SQL

    nested_clusters = <<-SQL
	(SELECT unnest(ST_ClusterWithin(
			c.lonlat::geometry,
			-- 63m
			ST_Distance( ST_GeomFromText('POINT(34.0151661 -118.49075029)', 4326), ST_GeomFromText('POINT(34.0153382 -118.4901983)', 4326) )
	)) AS cluster
  FROM commuting_stop_events c) AS sc, commuting_stop_events cse
  SQL

			where_sql = "ST_Contains(ST_CollectionExtract(sc.cluster, 1), cse.lonlat::geometry)"
			group_sql = 'sc.cluster'

      select(selects)
        .from(nested_clusters)
        .where(where_sql)
        .group(group_sql)
    end

    def as_json(attrs={})
      c = RGeo::GeoJSON.encode(centroid)
      cir = RGeo::GeoJSON.encode(circle)
      cluster = RGeo::GeoJSON.encode(geom_collection)
      { id: id, centroid: c, circle: cir, radius: radius, geom_collection: cluster }
    end
  end
end
