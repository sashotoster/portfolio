lock '~> 3.11.0' # config valid for current version and patch releases of Capistrano

set :application, 'portfolio'
set :repo_url, 'git@github.com:sashotoster/portfolio.git'
set :user, 'webmaster'
set :deploy_to, "/home/#{fetch(:user)}/#{fetch(:application)}"
set :keep_releases, 3
set :ssh_options, forward_agent: true
set :format_options, log_file: 'log/capistrano.log'
set :rvm_ruby_version, 'default'
set :npm_target_path, -> { release_path.join('client') }
set :bundle_jobs, 2 # Amount of cores
set :rollbar_token, ENV['BACKEND_ROLLBAR_TOKEN']
set :rollbar_env, Proc.new { fetch :stage }
set :rollbar_role, Proc.new { :web }

# append :linked_files, "config/database.yml"
append :linked_dirs, '.bundle', 'log', 'tmp', 'client/node_modules'
append :linked_files, '.env', 'client/.env'

after 'deploy:published', 'deploy:compile'
after 'deploy:published', 'deploy:restart'
after 'deploy:finishing', 'bundler:clean'

namespace :deploy do
  desc 'Build React frontend client'
  task :compile do
    on roles(:all) do
      execute "cd #{release_path}/client; npm run-script build"
      execute "cd #{release_path}/client; gzip -9kr build" # 9th level, keep originals, recursive
    end
  end

  desc 'Restart server'
  task :restart do
    on roles(:all) do
      execute 'sudo systemctl stop nginx'
      execute 'sudo systemctl stop backend'
      execute 'sudo systemctl start nginx'
      execute 'sudo systemctl start backend'
    end
  end
end
