require 'capistrano/setup'  # Load DSL and set up stages

require 'capistrano/deploy' # Include default deployment tasks

require 'capistrano/scm/git'
install_plugin Capistrano::SCM::Git

require 'capistrano/bundler'
require 'capistrano/npm'

# Load custom tasks from `lib/capistrano/tasks` if you have any defined
Dir.glob('lib/capistrano/tasks/*.rake').each { |r| import r }

# Stage defaults to production
invoke :production

