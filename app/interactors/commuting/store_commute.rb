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
      context.commute = Commute.create!(raw: context.payload,
                                        started_at: date,
                                        strava_activity_id: activity_id,
                                        name: name)
    rescue StandardError => e
      Rails.logger.error(e.message)
      context.fail!(message: "Unable to create commute: #{e.message}")
    end
  end
end
