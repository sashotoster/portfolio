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
      post_data = File.read('sample_data.json')
      target_days = 60

      google_response = begin
        query_data = Model.get_estimate(post_data, target_days)
        "Sent: \n" + query_data + "\n" + Model.query_google(query_data)
      rescue => error
        error.message + '||' + error.backtrace.inspect
      end
      json message: google_response
    end
  end

  not_found do
    status 404
    json error: 'Page not found'
  end
end

