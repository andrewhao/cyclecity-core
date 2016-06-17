# Defines the core upload and view TracksAPIs.
module Commuting
  class StoplightAPI < Grape::API
    version "v1", vendor: "g9labs"
    format :json

    namespace :commuting do
      resource :stoplights do
        desc "See all stoplight metrics"
        get do
          Commuting::StopEventCluster.all
        end
      end
    end
  end
end
