# Defines the core upload and view TracksAPIs.
module Commuting
  class StopReportsAPI < Grape::API
    version "v1", vendor: "g9labs"
    format :json

    namespace :commuting do
      resource :stop_reports do
        desc "See all stop reports"
        get do
          Commuting::StopReport.all
        end

        desc "upload a commute"
        params do
          requires :activityId, type: Integer
          requires :report, type: Array
        end

        post do
          ap params
          command = ::Commuting::StoreStopReport.call(payload: params)
          command.stop_report
        end
      end
    end
  end
end
