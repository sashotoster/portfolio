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

after 'deploy:published', 'deploy:permissions'
after 'deploy:published', 'deploy:compile'
after 'deploy:published', 'deploy:restart'
after 'deploy:finishing', 'bundler:clean'

namespace :deploy do
  desc 'Update and restart services'
  task :permissions do
    on roles(:all) do
      execute "sudo chown root:root #{release_path}/config/infra/alexandra-logrotate"
      execute "sudo chmod 644 #{release_path}/config/infra/alexandra-logrotate"
    end
  end

  desc 'Build React frontend client'
  task :compile do
    on roles(:all) do
      execute "cd #{release_path}/client; npm run-script build"
      execute "cd #{release_path}/client; find build -type f -exec zopfli {} \\;"
    end
  end

  desc 'Update and restart services'
  task :restart do
    on roles(:all) do
      execute 'sudo systemctl daemon-reload'
      execute 'sudo systemctl restart nginx'
      execute 'sudo systemctl restart backend'
      execute 'sudo systemctl restart remote_syslog'
    end
  end

  desc 'Links infrastructure configs: nginx, systemd, logrotate'
  task :infra do
    on roles(:all) do
      execute "sudo ln -sf #{release_path}/config/infra/backend.service /etc/systemd/system/backend.service"
      execute "sudo ln -sf #{release_path}/config/infra/nginx.conf /etc/nginx/nginx.conf"
      execute "sudo ln -sf #{release_path}/config/infra/alexandra /etc/nginx/sites-available/alexandra"
      execute "sudo ln -sf #{release_path}/config/infra/alexandra-logrotate /etc/logrotate.d/alexandra-logrotate"
      execute "sudo ln -sf #{release_path}/config/infra/log_files.yml /etc/log_files.yml"
    end
  end
end
