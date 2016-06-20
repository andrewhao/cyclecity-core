# A GeoJSON based serialization of
module Commuting
  class StoplightFeatureCollection
    attr_reader :stoplight_clusters

    def initialize(stoplight_clusters)
      @stoplight_clusters = stoplight_clusters
    end

    def wrap
      RGeo::GeoJSON.encode(entity_factory.feature_collection(stoplight_coordinates))
    end

    def wrap_circles
      RGeo::GeoJSON.encode(entity_factory.feature_collection(stoplight_circles))
    end

    private

    def stoplight_circles
      stoplight_clusters.map do |cluster|
        entity_factory.feature(
          cluster.circle,
          cluster.id,
          title: cluster.id,
          count: cluster.cluster_count,
          average_stop_duration: cluster['average_stop_duration']
        )
      end
    end

    def stoplight_coordinates
      stoplight_clusters.map do |cluster|
        centroid = entity_factory.feature(
          cluster.centroid,
          cluster.id,
          title: cluster.id,
          count: cluster.cluster_count,
          average_stop_duration: cluster['average_stop_duration']
        )
				centroid
      end
    end

    def entity_factory
      @entity_factory ||= RGeo::GeoJSON::EntityFactory.instance
    end
  end
end
