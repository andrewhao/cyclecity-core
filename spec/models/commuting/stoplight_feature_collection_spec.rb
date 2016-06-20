require 'rails_helper'

describe Commuting::StoplightFeatureCollection do
  let(:factory) { RGeo::Geographic.spherical_factory(srid: 4326) }
  let!(:stop_events) { create(:commuting_stop_event, lonlat: factory.point(10, 20)) }
  let(:clusters) { Commuting::StopEventCluster.all }

  subject { described_class.new(clusters) }

  describe '#wrap' do
    it 'returns a GeoJSON feature collection' do
      expect(subject.wrap['type']).to eq 'FeatureCollection'
      expect(subject.wrap['features']).to_not be_empty
    end

	  it 'returns stoplights' do
      feature = subject.wrap['features'].first
      expect(feature['type']).to eq 'Feature'
      expect(feature['geometry']).to eq({ 'type' => 'Point', 'coordinates' => [10.0, 20.0] })
    end

    it 'annotates with metadata' do
      feature = subject.wrap['features'].first
      expect(feature['properties']).to eq('count' => 1, 'title' => 1)
    end
  end
end
