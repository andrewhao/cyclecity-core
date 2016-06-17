require "rails_helper"

describe Commuting::StoplightAPI, type: :request do
  describe "GET stoplights" do
    it "returns 200 OK" do
      get "/api/v1/commuting/stoplights"
      expect(response).to be_ok
    end
  end
end
