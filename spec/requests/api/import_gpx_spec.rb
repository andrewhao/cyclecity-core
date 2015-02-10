require 'rails_helper'
describe "importing from API", type: :request do
  let(:url) { "http://share.abvio.com/5e3ba2f14c227d4b/Runmeter-Run-20150207-0639.gpx" }

  describe "importing from the API with a url" do
    it "increments track count" do
      post("/api/v1/tracks", url: url)
      expect(JSON.parse(response.body)).to include("status" => "processing")

      track = Track.last
      expect(track.file_uri).to include "filepicker.io"
    end

    it "creates a TrackAnalytic" do
      expect {
        post("/api/v1/tracks", url: url)
      }.to change { TrackAnalytic.count }.by(1)

      analytic = TrackAnalytic.last
      expect(analytic.stress_score).to be > 0
    end
  end
end
