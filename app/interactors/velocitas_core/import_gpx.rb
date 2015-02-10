module VelocitasCore
  class ImportGpx
    include Interactor

    def call
      gd = GpxDownloader.new(context.url)
      file = gd.download
      if gd.success?
        storage = StoreGpxFile.new(file: File.open(file))
        storage.call

        import_job = GpxImporter.new(File.open(file), storage.context.file_uri)
        import_job.import
      else
        context.fail!(message: "Download failed")
      end
    end
  end
end
