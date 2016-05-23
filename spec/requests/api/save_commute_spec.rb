require 'rails_helper'

describe "store stoplight report", type: :request do
  it "creates a Commuting::StopEvent" do
    json = File.read('spec/fixtures/sampleActivity.json')

    expect {
      post("/api/v1/commuting/activities", json, 'Content-Type': 'application/json')
    }.to change { Commuting::StopEvent.count }.by(1)
  end
end
