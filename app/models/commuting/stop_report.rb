module Commuting
  class StopReport < ActiveRecord::Base
    self.table_name = :commuting_stop_reports

    belongs_to :commuting_commute, class_name: 'Commuting::Commute'
  end
end
