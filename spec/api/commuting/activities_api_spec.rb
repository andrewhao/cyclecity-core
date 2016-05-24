require "rails_helper"

describe Commuting::ActivitiesAPI, type: :request do
  describe "GET activities" do
    it "returns 200 OK" do
      get "/api/v1/commuting/activities"
      expect(response).to be_ok
    end
  end

  describe "POST activities" do
    let(:json_payload) do
      {
        activity: {
          activityId: 123,
          name: "Rambling Man",
          activity: { },
          stream: [ ]
        },
        report: {
          activityId: 123
        }
      }
    end

    it "creates a commute object" do
      expect_any_instance_of(Commuting::StoreCommute).to receive(:call)
      post "/api/v1/commuting/activities", json_payload.to_json, 'Content-Type': 'application/json'
      expect(response).to be_created
    end
  end
end
