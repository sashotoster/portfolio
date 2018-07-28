# Change to match your CPU core count
workers 2

# Min and Max threads per worker
threads 1, 6

port 8080

environment ENV['PORTFOLIO_ENV'] || 'production'

app_dir = File.expand_path('../..', __FILE__)

# Set up socket location
bind "unix://#{app_dir}/tmp/sockets/puma.sock"

activate_control_app

on_worker_boot do
  # Database connection
  # require "active_record"
  # ActiveRecord::Base.connection.disconnect! rescue ActiveRecord::ConnectionNotEstablished
  # ActiveRecord::Base.establish_connection(YAML.load_file("#{app_dir}/config/database.yml")[rails_env])
end
