# Takes a GPX file, loads it up with the GPX lib and imports it into the DB
module VelocitasCore
  class GpxImporter
    attr_accessor :file

    def initialize(file)
      @file = file
    end

    def import
      gpx_file.tracks.each do |track|
        trk = Track.create title: title, activity: Activity.run
        pts = track.segments.flat_map(&:points)
        pts.each do |p|
          TrackPoint.create_from_gpx_track_point(p, parent_track: trk)
        end
      end
      true
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
