module VelocitasCore
  class ImportGpx
    include Interactor

    def call
      gd = GpxDownloader.new(context.url)
      file = gd.download
      if gd.success?
        storage = StoreGpxFile.new(file: File.open(file))
        storage.call

        import_job = GpxImporter.new(file: File.open(file),
                                     uri: storage.context.filepicker_file_uri)
        import_job.call

        analyze_track = AnalyzeTrack.new(file: file,
                                         track: import_job.context.tracks.try(:first))
        analyze_track.call
      else
        context.fail!(message: "Download failed")
      end
    end
  end
end
