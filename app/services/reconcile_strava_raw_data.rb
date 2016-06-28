class ReconcileStravaRawData
  def call
    Commuting::Commute.where(strava_athlete_id: nil).find_each do |commute|
      athlete_id = commute.raw['activity']['activity']['athlete']['id']
      commute.update(strava_athlete_id: athlete_id)
    end
  end
end
