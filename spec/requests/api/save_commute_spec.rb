require 'rails_helper'

describe "store commute", type: :request do
  describe "importing from the API with a url" do
    it "creates a Commute" do
      json = File.read('spec/fixtures/sampleActivity.json')

      expect {
        post("/api/v1/commuting/activities", json, 'Content-Type': 'application/json')
      }.to change { Commuting::Commute.count }.by(1)

    end
  end
end
