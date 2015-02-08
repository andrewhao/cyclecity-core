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
end
