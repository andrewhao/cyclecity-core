require "spec_helper"
require "rails_helper"

describe TrackPoint do
  let(:track) { build_stubbed(:track) }
  subject { build_stubbed(:track_point, track: track) }

  describe "factory test" do
    it "creates trackpoint" do
      expect(subject).to be_instance_of described_class
    end

    it "has a default coordinate" do
      expect(subject.coordinate).to be_instance_of RGeo::Geos::CAPIPointImpl
    end
  end

  describe "#elevation" do
    it "creates high elevations" do
      pending "This fails PG for some reason"
      described_class.create(elevation: 100.0)
    end
  end

  describe ".create_from_gpx_track_point" do 
    let(:lat) { 10 }
    let(:lon) { 11 }
    let(:elevation) { 9.0 }
    let(:time) { Time.now }
    let(:gpx_track_point) { GPX::TrackPoint.new lat: lat, lon: lon, elevation: elevation, time: time }

    subject { described_class.create_from_gpx_track_point(gpx_track_point, parent_track: track) }

    it "inserts a record from the corresponding GPX trackpoint" do
      expect {
        subject
      }.to change { TrackPoint.count }.by(1)
    end

    it "imports the correct latitude" do
      pending "not yet implemented"
      expect(subject.coordinate.x).to eq ""
    end

    it "imports the correct longitude" do
      pending "not yet implemented"
      expect(subject.coordinate.y).to eq ""
    end
  end
end
