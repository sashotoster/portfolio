# Change to match your CPU core count
workers 2

# Min and Max threads per worker
threads 1, 6

preload_app!

environment ENV['RACK_ENV'] || 'production'

app_dir = File.expand_path('../..', __FILE__)

if @options[:environment] == 'production'
  bind "unix://#{app_dir}/tmp/puma.sock"
else
  port 8080
end
