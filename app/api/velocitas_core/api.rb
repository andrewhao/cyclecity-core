# Defines the core upload and view APIs.
module VelocitasCore
  class API < Grape::API
    version "v1", vendor: "g9labs"
    format :json

    resource :tracks do
      desc "Show all tracks"
      get do
        tf = TrackFetcher.new
        tf.fetch
      end

      desc "upload a track"
      params do
        requires :url, type: String, desc: "Link to the GPX file, publicly accessible"
      end

      post do
        workflow = GpxImportWorkflow.new(params[:url])
        is_success = workflow.process
        {status: (is_success ? "processing" : "error")}
      end
    end

  end

  class GpxImportWorkflow
    attr_accessor :url

    def initialize(url)
      @url = url
    end

    def process
      gd = GpxDownloader.new(url)
      file = gd.download
      if gd.success?
        import_job = GpxImporter.new(File.open(file))
        import_job.import
      end
      gd.success?
    end
  end
end
