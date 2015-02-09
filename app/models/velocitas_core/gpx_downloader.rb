# Downloads a URL to a local file on the worker
module VelocitasCore
  class GpxDownloader
    attr_accessor :url, :response, :filename

    # @param [String] url The URL to the GPX file.
    # @param [String] filename (Optional) The desired filename of the desired file.
    #   Otherwise, it gets the name of the MD5 sum of its file contents.
    def initialize(url, filename: filename)
      @url = url
      @filename = filename
      @response = nil
    end

    def download
      @response = connection.get(url)
      if success?
        save!
      else
        nil
      end
    end

    def success?
      status == 200
    end

    def status
      response.try(:status)
    end

    private

    def contents
      @response.body
    end

    # Returns the handle to the File object that this file is downloaded to
    def save!
      file = File.new(File.join(basedir, computed_filename), 'wb')
      file.write contents
      file.close
      file
    end

    def basedir
      Rails.root.join("tmp")
    end

    def computed_filename
      filename || "#{SecureRandom.hex(12)}.gpx"
    end

    def connection
      @connnection ||= Faraday.new do |faraday|
        faraday.request  :url_encoded             # form-encode POST params
        faraday.response :logger                  # log requests to STDOUT
        faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
      end
    end
  end
end
