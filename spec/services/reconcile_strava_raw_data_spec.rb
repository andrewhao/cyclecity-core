require 'rails_helper'

describe ReconcileStravaRawData do
  describe '#call' do
    let(:athlete_id) { 234 }
    it 'fills in the strava_athlete_id' do
      raw = { activity: {
        activity: {
          id: 123,
          athlete: {
            id: athlete_id
          }
        }
      } }.to_json

      commute = create(:commuting_commute, raw: raw)
      expect {
        subject.call
      }.to change { commute.reload.strava_athlete_id }.from(nil).to(athlete_id)
    end
  end
end
