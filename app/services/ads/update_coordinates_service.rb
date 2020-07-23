# frozen_string_literal: true

module Ads
  class UpdateCoordinatesService
    prepend BasicService

    option :ad do
      option :id
      option :city
    end

    option :ads_service, default: proc { AdsService::HttpClient.new }

    attr_reader :ad

    def call
      coordinates = Geocoder.geocode(@ad.city)
      @ads_service.update_coordinates({ id: @ad.id, coordinates: coordinates }.to_json)
    end
  end
end
