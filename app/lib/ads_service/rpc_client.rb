# frozen_string_literal: true

require_relative 'rpc_api'

module AdsService
  class RpcClient
    extend Dry::Initializer[undefined: false]
    include RpcApi

    option :queue, default: proc { create_queue }
    option :reply_queue, default: proc { create_reply_queue }
    option :lock, default: proc { Mutex.new }
    option :condition, default: proc { ConditionVariable.new }

    def self.fetch
      Thread.current['ads_service.rpc_client'] ||= new.start
    end

    def start
      @reply_queue.subscribe do |_delivery_info, _properties, _payload|
        @lock.synchronize { @condition.signal }
      end

      self
    end

    private

    def create_queue
      channel = RabbitMq.channel
      channel.queue('ads', durable: true)
    end

    def create_reply_queue
      channel = RabbitMq.channel
      channel.queue('amq.rabbitmq.reply-to')
    end

    def publish(payload, opts = {})
      @lock.synchronize do
        @queue.publish(payload, opts.merge(app_id: 'geocoder', reply_to: @reply_queue.name))

        @condition.wait(@lock)
      end
    end
  end
end
