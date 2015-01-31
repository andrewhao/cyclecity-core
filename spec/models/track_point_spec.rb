require "spec_helper"
require "rails_helper"

describe TrackPoint do
  subject { create(:track_point) }

  describe "factory test" do
    it "creates trackpoint" do
      expect(subject).to be_instance_of described_class
    end

    it "has a default coordinate" do
      expect(subject.coordinate).to eq ""
    end
  end
end
