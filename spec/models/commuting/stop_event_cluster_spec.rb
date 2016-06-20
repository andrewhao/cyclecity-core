require 'rails_helper'

describe Commuting::StopEventCluster do
	let(:factory) { RGeo::Geos.factory(srid: 4326) }
	let(:lonlat1) { factory.point(28, 77) }
	let(:lonlat2) { factory.point(28, 77) }
  let!(:stop_event) { create(:commuting_stop_event, lonlat: lonlat1, duration: 3) }
  let!(:stop_event2) { create(:commuting_stop_event, lonlat: lonlat2, duration: 1) }

  subject { described_class.first }

  describe '.all' do
    it 'returns a set of clusters' do
      results = described_class.all
      expect(results.first).to be_instance_of(described_class)
    end
  end

  describe '.query' do
    it 'returns a cluster query' do
      results = described_class.query
      expect(results.first).to be_instance_of(described_class)
    end

		it 'returns a average_stop_duration metric for the cluster' do
      results = described_class.query
      expect(results.first['average_stop_duration']).to eq 2
		end
  end

  describe '#as_json' do
    it 'serializes to GeoJSON' do
      serialized = subject.as_json

      expect(serialized[:centroid]['type']).to eq 'Point'
      expect(serialized[:circle]['type']).to eq 'Point'
      expect(serialized[:geom_collection]['type']).to eq 'GeometryCollection'
      expect(serialized[:radius]).to eq 0.0
    end
  end
end
