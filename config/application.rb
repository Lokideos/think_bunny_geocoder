# frozen_string_literal: true

class Application
  def self.root
    File.expand_path('..', __dir__)
  end

  def self.environment
    File.fetch('RACK_ENV').to_sym
  end
end
