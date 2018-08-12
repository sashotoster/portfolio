require 'pry'
require 'capistrano/setup'  # Load DSL and set up stages
require 'capistrano/deploy' # Include default deployment tasks
require 'capistrano/scm/git'
require 'capistrano/rvm'
require 'capistrano/bundler'
require 'capistrano/npm'
require 'rollbar/capistrano3'
require 'dotenv'
Dotenv.load('.env')

# Load custom tasks from `lib/capistrano/tasks` if you have any defined
Dir.glob('lib/capistrano/tasks/*.rake').each { |r| import r }

install_plugin Capistrano::SCM::Git

# Stage defaults to production unless it's and index task to avoid the warning
invoke :production unless Rake.application.options.show_tasks
