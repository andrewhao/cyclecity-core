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

    it "submits a link to the GPX download service" do
      allow_any_instance_of(VelocitasCore::GpxImportWorkflow).to \
        receive(:process).
        and_return(true)
      do_request
      expect(response).to be_created
    end

    it "queues up a GPX download job" do
      expect_any_instance_of(VelocitasCore::GpxImportWorkflow).to \
        receive(:process).
        and_return(true)
      do_request
    end

    it "returns an error code when you don't supply the url param" do
      post "/api/v1/tracks"
      expect(response).to be_bad_request
    end

    context "JSON response" do
      it "returns a processing status JSON" do
        expect_any_instance_of(VelocitasCore::GpxImportWorkflow).to \
          receive(:process).
          and_return(true)
        do_request
        expect(JSON.parse(response.body)).to include("status" => "processing")
      end

      it "returns error status JSON if fail" do
        expect_any_instance_of(VelocitasCore::GpxImportWorkflow).to \
          receive(:process).
          and_return(false)
        do_request
        expect(JSON.parse(response.body)).to include("status" => "error")
      end
    end
  end
end
