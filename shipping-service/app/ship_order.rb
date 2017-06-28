require 'sneakers'
require 'json'

require_relative '../model/shipping'

Mongoid.load!('mongoid.config', 'development')

class OrderWorker
  include Sneakers::Worker
  from_queue 'orders'

  def work(message)
    puts message
    shipment = JSON.parse(message)
    shipment['status'] = true
    QueueConnection.publish(shipment)
    puts "#{shipment} published"
    ack!
  end
end
