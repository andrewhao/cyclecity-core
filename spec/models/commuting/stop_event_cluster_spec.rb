require 'rails_helper'

describe Commuting::StopEventCluster do
  let!(:stop_event) { create_list(:commuting_stop_event, 4) }
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
