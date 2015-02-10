require 'rails_helper'
describe "importing from API", type: :request do
  let(:url) { "http://share.abvio.com/5e3ba2f14c227d4b/Runmeter-Run-20150207-0639.gpx" }

  describe "importing from the API with a url" do
    it "increments track count" do 
      pending "fails for some reason"

      expect {
        post("/api/v1/tracks", url: url)
        sleep(1)
      }.to change { Track.count }.by(1)
    end

    it "returns a processing JSON" do
      post("/api/v1/tracks", url: url)
      expect(JSON.parse(response.body)).to include("status" => "processing")
    end
  end
end
