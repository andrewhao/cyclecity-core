require "rails_helper"

describe VelocitasCore::StoreGpxFile do
  let(:path) { Rails.root.join("spec", "fixtures", "simple.gpx") }
  let(:params) { {file: File.new(path) } }
  let(:context) { subject.context }
  subject { described_class.new(params) }

  describe "#call" do
    let(:handle) { "asdf" }
    let(:filename) { "myfilename.gpx" }
    let(:file_uri) { "1234" }
    let(:mock_response) do
      double("filepicker", filename: filename, handle: handle, file_uri: file_uri)
    end

    it "sends a FP API call" do
      expect_any_instance_of(FilepickerClient).to receive(:store).and_return(mock_response)
      subject.call

      expect(context.filepicker_filename).to eq filename
      expect(context.filepicker_handle).to eq handle
      expect(context.filepicker_file_uri).to eq file_uri
    end
  end
end
