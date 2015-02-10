require "rails_helper"

describe VelocitasCore::AnalyzeTrack do
  let(:track) { create(:track) }
  let(:file) { File.new(File.join(Rails.root, "spec", "fixtures", "actual.gpx")) }
  let(:context) { subject.context }

  subject { described_class.new(file: file, track: track) }

  describe "#call" do
    it "populates a TrackAnalytic for the Track" do
      expect {
        subject.call
      }.to change { TrackAnalytic.count }.by(1)
    end

    it "analyzes the stress score" do
      subject.call
      expect(context.track_analytic.stress_score).to be_instance_of BigDecimal
    end

    it "analyzes the grade adjusted pace" do
      subject.call
      expect(context.track_analytic.grade_adjusted_pace).to be_instance_of BigDecimal
    end

    it "analyzes the average (raw) pace" do
      subject.call
      expect(context.track_analytic.average_pace).to be_instance_of BigDecimal
    end

    it "links the track analytic to the track" do
      subject.call
      expect(context.track_analytic.reload.track).to eq track
    end
  end
end
