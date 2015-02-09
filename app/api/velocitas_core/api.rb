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
        gd = GpxDownloader.new(params[:url])
        file = gd.download
        if gd.success?
          import_job = GpxImporter.new(File.open(file))
          import_job.import
        end
        {status: (gd.success? ? "processing" : "error")}
      end
    end
  end
end
