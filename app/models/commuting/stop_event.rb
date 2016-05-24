module Commuting
  class StopEvent < ActiveRecord::Base
    self.table_name = :commuting_stop_events
    belongs_to :commuting_stop_report, class_name: "Commuting::StopReport"
    belongs_to :commuting_commute, class_name: "Commuting::Commute"
  end
end
