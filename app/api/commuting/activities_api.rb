# Defines the core upload and view TracksAPIs.
module Commuting
  class HandlePost
    include Interactor::Organizer

    organize StoreCommute, StoreStopReport
  end

  class ActivitiesAPI < Grape::API
    version "v1", vendor: "g9labs"
    format :json

    namespace :commuting do
      resource :activities do
        desc "See all commutes"
        get do
          Commuting::Commute.all
        end

        desc "upload a commute"
        params do
          requires :report, type: Hash
          requires :activity, type: Hash
        end

        post do
          command = HandlePost.call(payload: params)
          status (command.success? ? :created : :unprocessable_entity)
          command.commute
        end
      end
    end
  end
end
