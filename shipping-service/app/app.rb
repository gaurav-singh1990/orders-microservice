# server.rb
require 'sinatra'
require 'mongoid'

require_relative '../model/shipping'

Mongoid.load! 'mongoid.config'

get '/list' do
  Shipping.all.to_json
end
