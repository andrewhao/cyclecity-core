module Commuting
  class StoreStopReport
    include Interactor

    def call
      context.stop_report = Commuting::StopReport.create(
        commuting_commute: context.commute
      )
      context.stop_events = context.report.report
      context.stop_events.map do |report|
        Commuting::StopEvent.find_or_create_by(
          commuting_commute: context.commute,
          lonlat: "POINT(#{report.lon} #{report.lat})"
        ) do |se|
          se.stopped_at = report.stopped_at || Time.zone.now
          se.duration = report.elapsedTime
        end
      end
    end
  end
end
