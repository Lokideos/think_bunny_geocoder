# frozen_string_literal: true

require 'bunny'

class Producer
  def initialize(queue:)
    @connection = Bunny.new.start
    @channel = @connection.create_channel
    @queue = @channel.queue(queue)
  end

  def publish(payload)
    # @channel.default_exchange.publish(payload, routing_key: @queue.name)
    @queue.publish(payload)
  ensure
    @connection.close
  end
end

Producer.new(queue: 'tasks').publish('payload')
