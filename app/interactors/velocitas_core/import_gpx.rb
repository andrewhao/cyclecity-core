module VelocitasCore
  class ImportGpx
    include Interactor

    def call
      gd = GpxDownloader.new(context.url)
      file = gd.download
      if gd.success?
        import_job = GpxImporter.new(File.open(file))
        import_job.import
      else
        context.fail!(message: "Download failed")
      end
    end
  end
end
