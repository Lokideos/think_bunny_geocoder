# frozen_string_literal: true

channel = RabbitMq.consumer_channel
queue = channel.queue('geocoding', durable: true)

queue.subscribe(manual_ack: true) do |delivery_info, properties, payload|
  payload = JSON(payload)
  Thread.current[:request_id] = properties.headers['request_id']
  Application.with_time_metrics(:geocoding_request_seconds_response) do
    coordinates = Geocoder.geocode(payload['city'])

    Application.logger.info(
      'geocoded_coordinates',
      city: payload['city'],
      coordinates: coordinates
    )

    if coordinates.present?
      Metrics.geocoding_requests_total.increment(labels: { result: 'success' })
      client = AdsService::RpcClient.fetch
      client.update_coordinates(payload['id'], coordinates)
    else
      Metrics.geocoding_requests_total.increment(labels: { result: 'failure' })
    end
  end

  channel.ack(delivery_info.delivery_tag)
end
