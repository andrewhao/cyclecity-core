module VelocitasCore
  class StoreGpxFile
    include Interactor

    def call
      fl = context.file
      Rails.logger.info "Storing file as #{fl.inspect}"
      binding.pry
      stored_file = client.store(fl)

      context.filepicker_filename = stored_file.filename
      context.filepicker_handle = stored_file.handle
      context.filepicker_file_uri = stored_file.file_uri
    end

    private

    def client
      @client ||= FilepickerClient.new(ENV['FILEPICKER_API_KEY'],
                                       ENV['FILEPICKER_API_SECRET'])
    end
  end
end
