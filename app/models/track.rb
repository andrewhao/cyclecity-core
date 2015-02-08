# A GPX track corresponding to a user's workout.
class Track < ActiveRecord::Base
  belongs_to :activity

  validates :activity, presence: true
end
