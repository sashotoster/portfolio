require 'sinatra'
require 'sinatra/config_file'
require 'sinatra/json'

config_file 'config/config.yml'

set :server, :puma
set :port, 8080
set :environment, ENV['PORTFOLIO_ENV']

namespace '/api' do
  get '/' do
    json message: 'Main API route'
  end
end
