# frozen_string_literal: true

module Workers
  class EnqueueCoordinatesUpdate
    include Sidekiq::Worker
    sidekiq_options queue: :default, retry: 2, backtrace: 20

    def perform(ad)
      Ads::UpdateCoordinatesService.call(ad.deep_symbolize_keys)
    end
  end
end
