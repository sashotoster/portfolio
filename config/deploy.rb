# config valid for current version and patch releases of Capistrano
lock '~> 3.11.0'

set :application, 'portfolio'
set :repo_url, 'git@github.com:sashotoster/portfolio.git'
set :user, 'webmaster'

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
set :deploy_to, "/home/#{fetch(:user)}/#{fetch(:application)}"

set :keep_releases, 2

set :ssh_options, forward_agent: true

set :format_options, log_file: 'shared/logs/capistrano.log'

# Default value for :linked_files is []
# append :linked_files, "config/database.yml"

# Default value for linked_dirs is []
# append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "public/system"

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for local_user is ENV['USER']
# set :local_user, -> { `git config user.name`.chomp }

append :linked_dirs, '.bundle'

after 'deploy:published', 'bundler:clean'
