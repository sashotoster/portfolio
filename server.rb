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

    get '/reddit-trend' do
      url = 'https://www.reddit.com/r/personalfinance/comments/owhy0r/leverage_through_leaps_for_the_diy_investor/'
      target_days = 60

      google_response = begin
        Model.get_estimate(url, target_days)
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

