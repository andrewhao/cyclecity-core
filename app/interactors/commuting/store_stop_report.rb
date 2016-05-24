module Commuting
  class StoreStopReport
    include Interactor

    def call
      context.stop_report = Commuting::StopReport.create(
        commuting_commute: context.commute
      )
      context.stop_events = context.report.map do |report|
        Commuting::StopEvent.create(
          lonlat: "POINT(#{report[:lon]} #{report[:lat]})",
          stopped_at: Time.zone.now,
          duration: report[:elapsedTime],
          commuting_commute: context.commute
        )
      end
    end
  end
end
