require 'sinatra'
require 'sinatra/config_file'
require 'sinatra/json'
require 'sinatra/namespace'
require 'rollbar/middleware/sinatra'
require 'sinatra/cross_origin'

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
      cross_origin
      google_response = begin
        request.body.rewind
        query_data = Model.get_estimate(request.body.read)
      rescue => error
        "Sent: \n" + query_data + "\n" + error.message + "\n" + error.backtrace.inspect
      end
      json google_response
    end
    options "/reddit-trend" do
      response.headers["Allow"] = "HEAD,GET,PUT,POST,DELETE,OPTIONS"
      response.headers["Access-Control-Allow-Headers"] = "X-Requested-With, X-HTTP-Method-Override, Content-Type, Cache-Control, Accept"
      200
    end
  end

  not_found do
    status 404
    json error: 'Page not found'
  end
end

