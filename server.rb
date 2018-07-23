require 'sinatra'
require 'sinatra/config_file'
require 'sinatra/json'

config_file 'config/config.yml'

set :server, :puma
set :port, 8080

get '/' do
  json message: 'Main api route'
end
