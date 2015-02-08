require "rails_helper"

describe VelocitasCore::GpxImporter do
  let(:file) { File.new('spec/fixtures/simple.gpx') }
  subject { described_class.new(file) }

  describe "#import" do
    context "for the parent track" do
      it "creates a Track in the db" do
        expect {
          subject.import
        }.to change { Track.count }.by(1)
      end

      it "creates a track with the file name as the title by default" do
        subject.import
        expect(Track.last.title).to eq "simple"
      end

      it "adds an activity type of running for the default" do
        subject.import
        expect(Track.last.activity).to be_running
      end
    end

    context "importing each point" do
      it "loads up TrackPoints from the GPX file into the DB" do
      end
    end
  end
end
