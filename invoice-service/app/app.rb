require 'sneakers'
require 'json'

require_relative '../notification/notification_service'


class InvoiceWorker
  include Sneakers::Worker
  from_queue 'shipment'

  def work(message)
    puts message
    shipment = JSON.parse(message)
    NotificationService.notify(shipment)
    ack!
  end
end
