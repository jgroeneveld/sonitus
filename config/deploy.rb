set :rvm_ruby_string, '2.0.0-p0'
set :rvm_type, :system

set :application, "sonitus"
server "jgroeneveld.de", :app, :web, :db, :primary => true
set :deploy_to, "/var/www/apps/#{application}"

set :repository,  "git@github.com:jgroeneveld/sonitus.git"
set :scm, :git
set :deploy_via, :remote_cache

set :keep_releases, 5
after "deploy:restart", "deploy:cleanup"

# Thin
namespace :deploy do
    task :start, :roles => :app do
        run "cd #{current_path} && bundle exec thin start -C /etc/thin/sonitus.yml"
    end

    task :stop, :roles => :app do
        run "cd #{current_path} && bundle exec thin stop -C /etc/thin/sonitus.yml"
    end

    task :restart, :roles => :app do
        run "cd #{current_path} && bundle exec thin restart -C /etc/thin/sonitus.yml"
    end
end


after 'deploy:update_code', 'deploy:migrate'

require 'rvm/capistrano'
require "bundler/capistrano"