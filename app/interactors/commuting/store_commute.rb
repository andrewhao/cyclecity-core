module Commuting
  class StoreCommute
    include Interactor

    def call
      payload = context.payload
      name = payload.activity.name
      date = payload.activity.start_date
      Commute.create(raw: payload,
                     started_at: date,
                     name: name)
    end
  end
end
