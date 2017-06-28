require 'sneakers'
require 'json'

require_relative '../model/shipping'
require_relative '../queue/queue_connection'

Mongoid.load!('mongoid.config', 'development')

class OrderWorker
  include Sneakers::Worker
  from_queue 'orders'

  def work(message)
    puts message
    shipment = JSON.parse(message)
    shipment['status'] = true
    shipping = Shipping.new(shipment)
    result   = shipping.save
    puts result
    if result
      puts "#{ shipping.id } created"
      QueueConnection.publish(shipment.to_json)
      puts "#{ shipment } published"
    else
      puts "#{ shipping } couldn't be created"
    end

    ack!
  end
end
