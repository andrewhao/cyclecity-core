# Defines the core upload and view TracksAPIs.
module Commuting
  class ActivitiesAPI < Grape::API
    version "v1", vendor: "g9labs"
    format :json

    namespace :commuting do
      resource :activities do
        desc "See all commutes"
        get do
          {status: :processing, body: 'got it' }
        end

        desc "upload a commute"
        params do
          requires :activityId, type: Integer
          optional :name, type: String
          requires :activity, type: Hash
          requires :stream, type: Array
        end

        post do
          ap params
          command = ::Commuting::StoreCommute.call(payload: params)
          {status: command.success? ? :created : :error }
        end
      end
    end
  end
end
