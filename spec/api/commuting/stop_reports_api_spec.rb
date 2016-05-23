require "rails_helper"

describe Commuting::StopReportsAPI, type: :request do
  describe "GET stop_reports" do
    it "returns 200 OK" do
      get "/api/v1/commuting/stop_reports"
      expect(response).to be_ok
    end
  end

  describe "POST stop_reports" do
    let(:json_payload) do
      { activityId: 123,
        report: [] }
    end

    it "creates a StopReport object" do
      expect_any_instance_of(Commuting::StoreStopReport).to receive(:call).and_return(double(stop_report: true))
      post "/api/v1/commuting/stop_reports", json_payload.to_json, 'Content-Type': 'application/json'
      expect(response).to be_created
    end
  end
end
