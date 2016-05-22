# Defines the core upload and view TracksAPIs.
module VelocitasCore
  module Commuting
    class ActivitiesAPI < Grape::API
      version "v1", vendor: "g9labs"
      format :json

      namespace :commuting do
        resource :activities do
          desc "See all commutes"
          get do
            puts request.body
            {status: :processing, body: 'got it' }
          end

          desc "upload a commute"
          params do
          end

          post do
            puts "Receiving incoming commute activity"
            puts request.body
            puts params
            {status: :processing }
          end
        end
      end
    end
  end
end
