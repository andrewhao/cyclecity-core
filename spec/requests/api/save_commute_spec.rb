require 'rails_helper'

describe "store commute", type: :request do
  describe "importing from the API with a url" do
    it "creates a Commute" do
      json = {
        activityId: 123,
        activity: {
          name: 'My great commute',
          start_date: Time.zone.now,
        },
        stream: [ ]
      }.to_json

      expect {
        post("/api/v1/commuting/activities", json, format: :json)
      }.to change { Commuting::Commute.count }.by(1)

    end
  end
end
