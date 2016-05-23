module Commuting
  class StoreCommute
    include Interactor

    def call
      payload = context.payload
      name = payload.activity.name
      date = payload.activity.start_date
      activity_id = payload.activityId
      context.commute = Commute.create!(raw: payload,
                                        started_at: date,
                                        strava_activity_id: activity_id,
                                        name: name)
    rescue StandardError
      context.fail!(message: 'Unable to create commute')
    end
  end
end
