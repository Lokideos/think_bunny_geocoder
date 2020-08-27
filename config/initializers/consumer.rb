# frozen_string_literal: true

channel = RabbitMq.consumer_channel
queue = channel.queue('geocoding', durable: true)

queue.subscribe(manual_ack: true) do |delivery_info, properties, payload|
  payload = JSON(payload)
  Thread.current[:request_id] = properties.headers['request_id']
  coordinates = Geocoder.geocode(payload['city'])

  Application.logger.info(
    'geocoded_coordinates',
    city: payload['city'],
    coordinates: coordinates
  )

  if coordinates.present?
    client = AdsService::RpcClient.fetch
    client.update_coordinates(payload['id'], coordinates)
  end

  channel.ack(delivery_info.delivery_tag)
end
