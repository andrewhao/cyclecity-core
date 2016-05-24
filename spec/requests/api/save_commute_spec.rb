require 'rails_helper'

describe "store activity, including stoplight report", type: :request do
  let(:json) { File.read('spec/fixtures/sampleActivity.json') }

  it "creates a Commuting::Commute" do
    expect {
      post("/api/v1/commuting/activities", json, 'Content-Type': 'application/json')
    }.to change { Commuting::Commute.count }.by(1)
  end

  it 'stores events' do
    expect {
      post("/api/v1/commuting/activities", json, 'Content-Type': 'application/json')
    }.to change { Commuting::StopEvent.count }.by(1)
  end
end
