require 'sinatra'

set :server, :puma
set :port, 8080

get '/' do
  'Main api route'
end
