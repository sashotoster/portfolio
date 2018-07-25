# config valid for current version and patch releases of Capistrano
lock '~> 3.11.0'

set :application, 'portfolio'
set :repo_url, 'git@github.com:sashotoster/portfolio.git'
set :user, 'webmaster'
set :deploy_to, "/home/#{fetch(:user)}/#{fetch(:application)}"
set :keep_releases, 2
set :ssh_options, forward_agent: true
set :format_options, log_file: 'log/capistrano.log'
set :npm_target_path, -> { release_path.join('client') } # default not set
set :bundle_jobs, 2 # Equals to amount of cores
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# append :linked_files, "config/database.yml"
append :linked_dirs, '.bundle', 'log', 'tmp'

after 'deploy:published', 'deploy:compile'
after 'deploy:published',  'bundler:clean'


namespace :deploy do
  desc 'Build React frontend client'
  task :compile do
    on roles(:all) do
      execute "cd #{release_path}/client; npm run-script build"
    end
  end

  desc 'Turn server on'
  task :turn_on do
    on roles(:all) do
      execute "echo Not implemented"
    end
  end

  desc 'Turn server off'
  task :turn_ondo do
    on roles(:all) do
      execute "echo Not implemented"
    end
  end

  desc 'Purge tmp'
  task :purge_tmp do
    on roles(:all) do
      execute "echo Not implemented"
    end
  end
end

