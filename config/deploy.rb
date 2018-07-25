# config valid for current version and patch releases of Capistrano
lock '~> 3.11.0'

set :application, 'portfolio'
set :repo_url, 'git@github.com:sashotoster/portfolio.git'
set :user, 'webmaster'
set :deploy_to, "/home/#{fetch(:user)}/#{fetch(:application)}"
set :keep_releases, 2
set :ssh_options, forward_agent: true
set :format_options, log_file: 'shared/logs/capistrano.log'
# set :default_env, { path: "/opt/ruby/bin:$PATH" }
set :npm_target_path, -> { release_path.join('client') } # default not set
# set :bundle_jobs, 4 # Equals to amount of cores

# append :linked_files, "config/database.yml"
append :linked_dirs, '.bundle'#, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "public/system"

after 'deploy:published', 'bundler:clean'
