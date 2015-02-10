require "rails_helper"

describe VelocitasCore::ImportGpx do
  let(:url) { "http://www.foo.com/sample.gpx" }
  let(:context) { subject.context }
  subject do
    described_class.new(url: url)
  end
  let(:file) { File.open(File.join(Rails.root, "spec", "fixtures", "simple.gpx")) }

  describe "#call" do
    it "downloads gpx and imports it" do
      expect_any_instance_of(VelocitasCore::GpxDownloader).to \
        receive(:download).and_return(file)
      expect_any_instance_of(VelocitasCore::GpxDownloader).to \
        receive(:success?).and_return(true)
      expect_any_instance_of(VelocitasCore::GpxImporter).to \
        receive(:call).and_return(true)
      expect_any_instance_of(VelocitasCore::StoreGpxFile).to \
        receive(:call).and_return(true)
      expect_any_instance_of(VelocitasCore::AnalyzeTrack).to \
        receive(:call).and_return(true)
      subject.call

      expect(context).to be_a_success
    end

    it "fails when download fails" do
      allow_any_instance_of(VelocitasCore::GpxDownloader).to \
        receive(:download).and_return(file)
      allow_any_instance_of(VelocitasCore::GpxDownloader).to \
        receive(:success?).and_return(false)
      expect {
        subject.call
      }.to raise_error(Interactor::Failure)

      expect(context).to be_a_failure
    end
  end
end
