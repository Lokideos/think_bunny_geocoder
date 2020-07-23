# frozen_string_literal: true

redis_host = Settings.redis.host
redis_port = Settings.redis.port
redis_url = "redis://#{redis_host}:#{redis_port}/1"

Sidekiq.options[:dead_max_jobs] = 1_500_000 # (>^_^)>(^)(^_^)(^)<(^_^<)
Sidekiq.configure_client do |config|
  config.redis = { url: redis_url, db: 0, network_timeout: 15 }
end
Sidekiq.configure_server do |config|
  config.redis = { url: redis_url, db: 0, network_timeout: 15 }
end
