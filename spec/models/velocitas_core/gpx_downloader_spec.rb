require "rails_helper"

require "rails_helper"

describe VelocitasCore::GpxDownloader do
  subject { described_class.new(url) }
  let(:url) { "http://www.foo.com/me.gpx" }

  describe "#download" do
    it "downloads a GPX file" do
      mock_response = double(body: "<trk></trk>", status: 200)
      expect_any_instance_of(Faraday::Connection).to receive(:get).with(url).and_return(mock_response)
      subject.download
    end

    it "returns a File reference to where a file was saved" do
      mock_response = double(body: "<trk></trk>", status: 200)
      expect_any_instance_of(Faraday::Connection).to receive(:get).with(url).and_return(mock_response)
      expect(subject.download).to be_instance_of File
    end

    context "with supplied filename" do
      subject { described_class.new(url, filename: "foo.gpx") }

      it "saves the file with supplied filename" do
        mock_response = double(body: "<trk></trk>", status: 200)
        expect_any_instance_of(Faraday::Connection).to receive(:get).with(url).and_return(mock_response)
        expect(subject.download.path).to include "foo.gpx"
      end
    end
  end

  describe "#success?" do
    it "returns true if the response returned with an OK status" do
      mock_response = double(body: "<trk></trk>", status: 200)
      expect_any_instance_of(Faraday::Connection).to receive(:get).with(url).and_return(mock_response)
      subject.download
      expect(subject).to be_success
    end

    it "returns false if the response has not yet been initiated" do
      expect(subject).to_not be_success
    end

    it "returns false if the response came back with an error" do
      mock_response = double(body: "<trk></trk>", status: 404)
      expect_any_instance_of(Faraday::Connection).to receive(:get).with(url).and_return(mock_response)
      subject.download
      expect(subject).to_not be_success
    end
  end
end
