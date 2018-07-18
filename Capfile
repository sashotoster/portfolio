require 'capistrano/setup'  # Load DSL and set up stages

require 'capistrano/deploy' # Include default deployment tasks

require 'capistrano/scm/git'
install_plugin Capistrano::SCM::Git

require 'capistrano/rvm'
require 'capistrano/bundler'
require 'capistrano/puma'
require 'capistrano3-nginx'
require 'capistrano-nvm'

# Load custom tasks from `lib/capistrano/tasks` if you have any defined
Dir.glob('lib/capistrano/tasks/*.rake').each { |r| import r }

# Stage defaults to production
invoke :production

