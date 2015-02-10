# Takes a GPX file, loads it up with the GPX lib and imports it into the DB
module VelocitasCore
  class GpxImporter
    include Interactor

    delegate :file, :uri, to: :context

    def call
      context.tracks = []
      gpx_file.tracks.each do |track|
        trk = Track.create title: title, activity: Activity.run, file_uri: uri
        context.tracks << trk
        pts = track.segments.flat_map(&:points)
        pts.each do |p|
          TrackPoint.create_from_gpx_track_point(p, parent_track: trk)
        end
      end
    end

    private

    def gpx_file
      @gpx_file ||= ::GPX::GPXFile.new(gpx_file: file)
    end

    def title
      name = File.basename(file)
      parts = name.split(".")
      parts.pop if parts.length > 1
      parts.join(".")
    end
  end
end
