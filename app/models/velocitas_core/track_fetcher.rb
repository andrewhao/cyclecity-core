# Grabs a full track listing for the provided
# credentials.
module VelocitasCore
  class TrackFetcher

    # Currently just fetches a global list.
    def fetch
      Track.all
    end
  end
end

