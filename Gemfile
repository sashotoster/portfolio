ruby '2.5.5'
source 'https://rubygems.org'

# configuring https for bundler
git_source(:github) {|repo_name| "https://github.com/#{repo_name}" }

# Core
gem 'sinatra', '~> 2.0'
gem 'sinatra-contrib', '~> 2.0'
gem 'puma', '~> 3.12'
gem 'dotenv', '~> 2.5'
gem 'rollbar', '~> 2.16'
gem 'pry', '~> 0.11'

group :development do
  gem 'capistrano', '~> 3.11'
  gem 'capistrano-rvm', '~> 0.1'
  gem 'capistrano-bundler', '~> 1.6'
  gem 'capistrano-npm', '~> 1.0'
  gem 'pry-byebug', '~> 3.6'
end
