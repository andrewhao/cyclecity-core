require 'rails_helper'

describe Commuting::StoreStopReport do
  let(:commute) { Commuting::Commute.create }
  let(:params) do
    { commute: commute,
      report: [
        { lat: 1,
          lon: 118,
          elapsedTime: 22
        }, {
          lat: 2,
          lon: 119,
          elapsedTime: 3
        }
      ] }
  end

  describe '.call' do
    subject { described_class.call(params) }
    it 'creates a StopReport' do
      expect {
        subject
      }.to change { Commuting::StopReport.count }.by(1)
      expect(Commuting::StopReport.last.commuting_commute_id).to eq commute.id
    end

    it 'creates a series of StopEvents' do
      expect {
        subject
      }.to change { Commuting::StopEvent.count }.by(2)
    end
  end
end
