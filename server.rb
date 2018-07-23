require 'sinatra'
require 'sinatra/config_file'

config_file 'config/config.yml'


set :server, :puma
set :port, 8080

get '/' do
  'Main api route'
end
