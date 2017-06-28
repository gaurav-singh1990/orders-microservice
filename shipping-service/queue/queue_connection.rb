require "bunny"

module QueueConnection
  @exchange = nil
  @queue    = nil

  def self.get_exchange
    connection = Bunny.new("amqp://guest:guest@localhost:5672")
    connection.start
    channel    = connection.create_channel
    @exchange  = channel.direct("microservice1", durable: true)
    @queue     = channel.queue("shipment", :durable => true).bind(@exchange)
  end

  def self.publish(message)
    @exchange = @exchange || get_exchange
    @exchange.publish(message, routing_key: @queue.name)
  end
end
