require 'rails_helper'

describe Commuting::StopEventCluster do
  describe '#as_json' do
    it 'serializes to geoJSON' do
      subject.as_json
    end
  end
end
