# frozen_string_literal: true

source "https://rubygems.org"

git_source(:github) {|repo_name| "https://github.com/#{repo_name}" }

gem 'rake', '~> 13.0.1'
gem 'puma', '~> 4.3.0'
gem 'roda', '~> 3.33.0'

gem 'i18n', '~> 1.8.2'
gem 'config', '~> 2.2.1'

gem 'bunny', '~> 2.15.0'

gem 'dry-initializer', '~> 3.0.3'
gem 'dry-validation', '~> 1.5.0'

gem 'activesupport', '~> 6.0.0', require: false
gem 'fast_jsonapi', '~> 1.5'

gem 'faraday', '~> 1.0.0'
gem 'faraday_middleware', '~> 1.0.0'

group :development, :test do
  gem 'pry-byebug'
  gem 'rack-unreloader', '~> 1.7.0'
end

group :test do
  gem 'rspec', '~> 3.9.0'
  gem 'factory_bot', '~> 5.2.0'
end
