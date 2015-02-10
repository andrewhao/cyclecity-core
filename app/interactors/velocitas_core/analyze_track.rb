# Inserts analytic data in for the track, using the
# stressfactor library for data.
module VelocitasCore
  class AnalyzeTrack
    include Interactor

    def call
      context.track_analytic = TrackAnalytic.create(
        track: track,
        stress_score: stress_calculator.calculate,
        average_pace: pace_calculator.calculate(strategy: :raw, units: :metric),
        grade_adjusted_pace: pace_calculator.calculate(strategy: :grade_adjusted, units: :metric)
      )
    end

    delegate :file, :track, to: :context

    # FIXME/ahao This needs to be injected in, provided by the current user.
    def threshold_pace
      3.8
    end

    def loader
      @loader ||= Stressfactor::GpxLoader.new(file.path)
    end

    def pace_calculator
      @pace_calculator ||= Stressfactor::PaceCalculator.new(loader)
    end

    def stress_calculator
      @stress_calculator ||= Stressfactor::StressCalculator.new(threshold_pace: threshold_pace,
                                                                loader: loader)
    end
  end
end
