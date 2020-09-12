# frozen_string_literal: true

module Metrics
  module_function

  def configure
    registry = Prometheus::Client.registry
    yield registry

    registry.metrics.each do |m|
      define_method(m.name) { m }
    end
  end
end
