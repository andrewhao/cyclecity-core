# A GPX track corresponding to a user's workout.
class Track < ActiveRecord::Base
  belongs_to :activity
  has_one :track_analytic

  validates :activity, presence: true
end
