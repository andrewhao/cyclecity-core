require 'rails_helper'

describe Commuting::StoreCommute do
  let(:started) { Time.zone.now }
  let(:athlete_id) { 12345 }
  let(:commute_data) do
    Hashie::Mash.new({
      activity: {
        activity: {
          id: 123,
          name: 'My great commute',
          start_date: started,
          athlete: {
            id: athlete_id
          },
        },
        stream: [],
      },
      report: {
        activityId: 123
      }
    })
  end
  let(:params) { { payload: commute_data } }
  let(:context) { subject.context }
  subject { described_class.new(params) }

  describe "#call" do
    it 'saves a new Commuting::Commutes into the DB' do
      expect {
        subject.call
      }.to change { Commuting::Commute.count }.by(1)
      created_commute = Commuting::Commute.last

      expect(created_commute.name).to eq 'My great commute'
      expect(created_commute.started_at.to_i).to eq started.to_i
      expect(created_commute.strava_activity_id).to eq 123
      expect(created_commute.strava_athlete_id).to eq athlete_id
      expect(created_commute.raw['activity']).to be_instance_of Hash
    end

    it 'does not create an activity dupe' do
      Commuting::Commute.create(strava_activity_id: 123)

      expect {
        subject.call
      }.to_not change { Commuting::Commute.count }
    end
  end
end
