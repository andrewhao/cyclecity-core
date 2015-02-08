class Activity < ActiveRecord::Base
  def unknown?
    key == "unknown"
  end

  def run?
    key == "run"
  end

  def self.run
    find_by_key "run"
  end
end
