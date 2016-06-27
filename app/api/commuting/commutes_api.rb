# Defines the core upload and view TracksAPIs.
module Commuting
  class HandlePost
    include Interactor::Organizer

    organize StoreCommute, StoreStopReport
  end

  class CommutesAPI < Grape::API
    version "v1", vendor: "g9labs"
    format :json

    helpers do
      params :pagination do
        optional :page, type: Integer
        optional :per_page, type: Integer
      end
    end

    namespace :commuting do
      resource :commutes do
        desc "See all commutes"

        params do
          use :pagination
        end

        get do
          Commuting::Commute.page(params[:page]).per(params[:per_page])
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
