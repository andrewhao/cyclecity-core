# Takes a GPX file, loads it up with the GPX lib and imports it into the DB
module VelocitasCore
  class GpxImporter
    attr_accessor :file

    def initialize(file)
      @file = file
    end

    def import
      Track.create title: title
    end

    private

    def title
      name = File.basename(file)
      parts = name.split(".")
      parts.pop if parts.length > 1
      parts.join(".")
    end
  end
end
