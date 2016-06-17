# Defines the core upload and view TracksAPIs.
module Commuting
  class StoplightAPI < Grape::API
    version "v1", vendor: "g9labs"
    format :json

    helpers do
      params :pagination do
        optional :page, type: Integer
        optional :per_page, type: Integer
      end
    end

    namespace :commuting do
      resource :stoplights do
        desc "See all stoplight metrics"

        params do
          use :pagination
        end

        get do
          clusters = Commuting::StopEventCluster.page(params[:page]).per(params[:per_page])
          Rails.logger.info "[StoplightAPI] #get: #{clusters.inspect}"
          Rails.logger.info "[StoplightAPI] #get: #{clusters.map(&:as_json)}"
          clusters.as_json
        end
      end
    end
  end
end
