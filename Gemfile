# frozen_string_literal: true

source "https://rubygems.org"

git_source(:github) {|repo_name| "https://github.com/#{repo_name}" }

gem 'rake', '~> 13.0.1'
gem 'rack', '~> 2.2.3'
gem 'puma', '~> 4.3.0'

gem 'i18n', '~> 1.8.2'
gem 'config', '~> 2.2.1'

gem 'bunny', '~> 2.15.0'
gem 'ougai', '~> 1.8.5'
gem 'prometheus-client', '~> 2.1.0'

gem 'dry-initializer', '~> 3.0.3'
gem 'dry-validation', '~> 1.5.0'

gem 'activesupport', '~> 6.0.0', require: false
gem 'fast_jsonapi', '~> 1.5'

group :development, :test do
  gem 'pry-byebug'
  gem 'amazing_print'
end

group :test do
  gem 'rspec', '~> 3.9.0'
  gem 'factory_bot', '~> 5.2.0'
end
