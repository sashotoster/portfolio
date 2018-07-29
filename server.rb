require 'sinatra'
require 'sinatra/config_file'
require 'sinatra/json'
require 'sinatra/namespace'

config_file 'config/config.yml'

set :server, :puma
set :port, 8080
set :environment, ENV['PORTFOLIO_ENV']

namespace '/api' do
  get '' do
    json message: 'Main API route'
  end
end

not_found do
  status 404
  json error: 'Page not found'
end
