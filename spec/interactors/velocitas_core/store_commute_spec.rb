require 'spec_helper'

describe VelocitasCore::StoreCommute do
  let(:commute_data) do
    {
      stops: [{lat: 12, lon: 10}],
      stream: [
        {}, {}
      ]
    }
  end
  let(:params) { { commute: commute_data } }
  let(:context) { subject.context }
  subject { described_class.new(params) }

  describe "#call" do
    it 'saves a new Commuting::Commutes into the DB' do
    end

    it 'saves a set of new Commuting::Stops into the DB' do
    end
  end
end
