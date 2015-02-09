require "rails_helper"

describe VelocitasCore::API, type: :request do
  describe "GET tracks" do
    it "returns a list of tracks" do
      expected_tracks = ['track']
      expect_any_instance_of(VelocitasCore::TrackFetcher).to receive(:fetch).and_return(expected_tracks)
      get "/api/v1/tracks"
      expect(response.body).to eq expected_tracks.to_json
    end

    it "returns 200 OK" do
      get "/api/v1/tracks"
      expect(response).to be_ok
    end
  end

  describe "POST tracks" do
    let(:url) { "http://www.google.com" }

    let(:do_request) do
      post "/api/v1/tracks", url: url
    end

    it "queues up an import task and returns a 200 OK" do
      allow_any_instance_of(VelocitasCore::ImportGpx).to \
        receive(:call).
        and_return(double(success?: true))
      do_request
      expect(response).to be_created
    end

    it "returns an error code when you don't supply the url param" do
      post "/api/v1/tracks"
      expect(response).to be_bad_request
    end

    context "JSON response" do
      it "returns a processing status JSON if success" do
        expect_any_instance_of(VelocitasCore::ImportGpx).to \
          receive(:call).and_return(true)
        expect_any_instance_of(VelocitasCore::ImportGpx).to \
          receive(:context)
          .and_return(double(success?: true))
        do_request
        expect(JSON.parse(response.body)).to include("status" => "processing")
      end

      it "returns error status JSON if fail" do
        expect_any_instance_of(VelocitasCore::ImportGpx).to \
          receive(:call).and_return(true)
        expect_any_instance_of(VelocitasCore::ImportGpx).to \
          receive(:context)
          .and_return(double(success?: false))
        do_request
        expect(JSON.parse(response.body)).to include("status" => "error")
      end
    end
  end
end
