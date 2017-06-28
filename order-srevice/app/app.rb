require 'sinatra'
require 'mongoid'

require_relative '../model/order'
require_relative '../queue/rabbitmq_connection'

Mongoid.load! 'mongoid.config'

get '/list' do
  Order.all.to_json
end

post '/create' do
  params = JSON.parse request.body.read
  order = Order.new(params)
  if order.save
    # push message to shipping service
    QueueConnection.publish(params.to_json)
    'Order created'
  else
    status 422
    body params.to_json
  end
end
