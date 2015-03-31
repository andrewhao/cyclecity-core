require 'rails_helper'

describe Activity, :type => :model do
  let(:key) { "run" }
  subject { build_stubbed :activity, key: key }

  describe "#run?" do
    it "returns true" do
      expect(subject).to be_run
    end
  end

  describe "#unknown?" do
    let(:key) { "unknown" }

    it "returns true" do
      expect(subject).to be_unknown
    end
  end
end
