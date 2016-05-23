require "rails_helper"

describe Commuting::ActivitiesAPI, type: :request do
  describe "GET activities" do
    it "returns 200 OK" do
      get "/api/v1/tracks"
      expect(response).to be_ok
    end
  end

  describe "POST activities" do
    let(:url) { "http://www.google.com" }
    let(:json_payload) do
      { activityId: 123,
        name: "Rambling Man",
        activity: { },
        stream: [ ] }
    end

    it "queues up an import task and returns a 200 OK" do
      expect_any_instance_of(Commuting::StoreCommute).to receive(:call)
      post "/api/v1/commuting/activities", json_payload.to_json, 'Content-Type': 'application/json'
      expect(response).to be_created
    end

    xit "returns an error code when you don't supply the url param" do
      expect(response).to be_bad_request
    end
  end
end
