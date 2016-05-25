module Commuting
  class StoreCommute
    include Interactor

    def call
      context.report = context.payload.report
      context.activity = context.payload.activity
      activityDetails = context.activity.activity

      name = activityDetails.name
      date = activityDetails.start_date
      activity_id = activityDetails.id

      context.commute = Commute.find_or_create_by!(strava_activity_id: activity_id) do |c|
        c.raw = context.payload
        c.started_at = date
        c.name = name
      end
    rescue StandardError => e
      Rails.logger.error(e.message)
      context.fail!(message: "Unable to create commute: #{e.message}")
    end
  end
end
