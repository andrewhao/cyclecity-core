module VelocitasCore
  class API < Grape::API
    version "v1", vendor: "g9labs"
    format :json

    resource :tracks do
      desc "Show all tracks"
      get do
        "All tracks!"
      end
    end
  end
end
