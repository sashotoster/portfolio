# Change to match your CPU core count
workers 2

# Min and Max threads per worker
threads 1, 6

port 8080

environment ENV['PORTFOLIO_ENV'] || 'production'

app_dir = File.expand_path('../..', __FILE__)
shared_dir = "#{app_dir}/shared"

# Set up socket location
#bind "unix://#{shared_dir}/sockets/puma.sock"

# Logging
stdout_redirect "#{shared_dir}/log/puma.stdout.log", "#{shared_dir}/log/puma.stderr.log", true

# Set master PID and state locations
pidfile "#{shared_dir}/pids/puma.pid"
state_path "#{shared_dir}/pids/puma.state"
activate_control_app

on_worker_boot do
  # Database connection
  # require "active_record"
  # ActiveRecord::Base.connection.disconnect! rescue ActiveRecord::ConnectionNotEstablished
  # ActiveRecord::Base.establish_connection(YAML.load_file("#{app_dir}/config/database.yml")[rails_env])
end
