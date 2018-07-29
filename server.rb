require 'sinatra'
require 'sinatra/config_file'
require 'sinatra/json'
require 'sinatra/namespace'

class Backend < Sinatra::Application

  set run: false
  set :environment, (ENV['PORTFOLIO_ENV'] || 'production')

  config_file 'config/config.yml'

  namespace '/api' do
    get '' do
      json message: 'Main API route'
    end
  end

  not_found do
    status 404
    json error: 'Page not found'
  end
end

