require 'rails_helper'

describe Activity, :type => :model do
  let(:key) { "run" }
  subject { build_stubbed key: key }

  describe "#run?" do
    it "returns true" do
      expect(subject).to be_run
    end
  end
end
