# frozen_string_literal: true

module AdsService
  module HttpApi
    def update_coordinates(coordinates_response)
      connection.post('update_coordinates') do |request|
        request.body = coordinates_response
      end
    end
  end
end
