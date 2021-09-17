require 'sinatra'
require 'sinatra/config_file'
require 'sinatra/json'
require 'sinatra/namespace'
require 'rollbar/middleware/sinatra'

require_relative 'model.rb'

Rollbar.configure do |config|
  config.enabled = ENV['RACK_ENV'] == 'production'
  config.environment = ENV['RACK_ENV']
  config.access_token = ENV['BACKEND_ROLLBAR_TOKEN']
end

class Backend < Sinatra::Application
  use Rollbar::Middleware::Sinatra
  set :environment, ENV['RACK_ENV']

  config_file 'config/config.yml'

  namespace '/api' do
    get '' do
      json message: 'Main API route'
    end

    post '/reddit-trend' do
      output = begin
        @post_data = JSON.parse request.body.read
        query_data = Model.get_estimate(@post_data, params['target_days'].to_i)
      rescue => error
        "Sent: \n" + query_data + "\n" + error.message + "\n" + error.backtrace.inspect
      end
      json message: output
    end
  end

  not_found do
    status 404
    json error: 'Page not found'
  end
end

