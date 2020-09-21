# frozen_string_literal: true

class Application
  class << self
    attr_accessor :logger

    def root
      File.expand_path('..', __dir__)
    end

    def environment
      ENV.fetch('RACK_ENV').to_sym
    end

    def with_time_metrics(metric_name)
      start_time = Time.now

      yield

      finish_time = Time.now
      delta_time = finish_time - start_time
      Metrics.public_send(metric_name).observe(delta_time, labels: { time: 'Geocoding time' })
    end
  end
end
