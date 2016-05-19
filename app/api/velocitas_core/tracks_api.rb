# Defines the core upload and view TracksAPIs.
module VelocitasCore
  class TracksAPI < Grape::API
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
        workflow = VelocitasCore::ImportGpx.new(params)
        workflow.call
        {status: (workflow.context.success? ? "processing" : "error")}
      end
    end
  end
end
