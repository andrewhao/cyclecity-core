require "rails_helper"

describe Commuting::StoplightAPI, type: :request do
  describe "GET stoplights" do
    let!(:stop_events) { create_list(:commuting_stop_event, 2) }
    let(:stop_cluster) { Commuting::StopEventCluster.first }

    it "returns 200 OK" do
      get "/api/v1/commuting/stoplights"
      expect(response).to be_ok
    end

    it 'returns the stop cluster' do
      get "/api/v1/commuting/stoplights"
      expect(response.body).to eq [stop_cluster].to_json
    end
  end
end
