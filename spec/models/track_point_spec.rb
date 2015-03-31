require "spec_helper"
require "rails_helper"

describe TrackPoint do
  let(:track) { build_stubbed(:track) }
  subject { build_stubbed(:track_point, track: track) }

  describe ".create_from_gpx_track_point" do
    let(:lat) { 10 }
    let(:lon) { 11 }
    let(:elevation) { 9.0 }
    let(:time) { Time.now }
    let(:gpx_track_point) do
      GPX::TrackPoint.new(
        lat: lat,
        lon: lon,
        elevation: elevation,
        time: time
      )
    end

    subject { described_class.create_from_gpx_track_point(gpx_track_point, parent_track: track) }

    it "inserts a record from the corresponding GPX trackpoint" do
      expect {
        subject
      }.to change { TrackPoint.count }.by(1)
    end

    it "imports the correct longitude" do
      expect(subject.longitude).to eq lon
    end

    it "imports the correct latitude" do
      expect(subject.latitude).to eq lat
    end

    it "imports the correct elevation" do
      expect(subject.elevation).to eq elevation
    end
  end
end
