require 'rails_helper'

describe "store activity, including stoplight report", type: :request do
  let(:json) { File.read('spec/fixtures/sampleActivity.json') }

  it "returns 200" do
    post("/api/v1/commuting/commutes", json, 'Content-Type': 'application/json')
    expect(response).to be_created
  end

  it "creates a Commuting::Commute" do
    expect {
      post("/api/v1/commuting/commutes", json, 'Content-Type': 'application/json')
    }.to change { Commuting::Commute.count }.by(1)
  end

  it 'stores events' do
    expect {
      post("/api/v1/commuting/commutes", json, 'Content-Type': 'application/json')
    }.to change { Commuting::StopEvent.count }.by(1)
  end
end
