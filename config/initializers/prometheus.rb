# frozen_string_literal: true

require 'prometheus/client'
require 'prometheus/middleware/exporter'

Metrics.configure do |registry|
  registry.counter(
    :geocoding_requests_total,
    docstring: 'The total number of geocoding requests.',
    labels: %i[result]
  )
  registry.histogram(
    :geocoding_request_seconds_response,
    docstring: 'Histogram representation of geocoding response in seconds',
    labels: %i[time]
  )
end
