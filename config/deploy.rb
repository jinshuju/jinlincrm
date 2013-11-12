set :rvm_ruby_string, ENV['GEM_HOME'].gsub(/.*\//, "")
set :rvm_type, :system
require "rvm/capistrano"
require "bundler/capistrano"
require 'sidekiq/capistrano'
require 'puma/capistrano'
load 'deploy/assets'

set :application, "jinlincrm"
set :repository, "git@github.com:thscn/jinlincrm.git"
set :deploy_to, "/var/apps/#{application}"
set :scm, :git
set :user, "deployer"
set :git_shallow_clone, 1
set :use_sudo, false

task :prod do
  set :branch, "master"
  set :rails_env, "production"
  set :port, 6715
  role :web, "deployer@42.121.54.91"
  role :app, "deployer@42.121.54.91"
  role :db, "deployer@42.121.54.91", :primary => true
end

# task :create_sockets_dir, :roles => :app, :except => {:no_release => true} do
#   run "mkdir #{shared_path}/sockets"
# end

# task :symlink_sockets, :roles => :app, :except => {:no_release => true} do
#   run "ln -s #{shared_path}/sockets #{release_path}/tmp/sockets"
# end

# task :run_migrate_task, :roles => :app, :except => {:no_release => true} do
#   run "cd #{current_path}; RAILS_ENV=#{rails_env} bundle exec rake tmp:cache:clear #{ENV['task']}"
# end

task :write_deploy_version, :roles => :app, :except => {:no_release => true} do
  run "cd #{release_path} && cp REVISION public/deploy-version.html && echo ${PWD##*/} >> public/deploy-version.html"
end

# task :cp_setting_files, :roles => :app, :except => {:no_release => true} do
#   run "cp #{shared_path}/config/* #{release_path}/config/" if rails_env == "production"
# end

task :bundle_install, :roles => :app, :except => {:no_release => true} do
  run [
          # "source /usr/local/rvm/scripts/rvm",
          "rvm rvmrc trust #{release_path}",
          "cd #{release_path}",
          "bundle install"
      ].join(" && ")
end

# namespace :deploy do
#   task :restart, :roles => :app, :except => {:no_release => true} do
#     unicorn_pid = "#{shared_path}/pids/unicorn.pid"
#     run [
#             "rvm rvmrc trust #{current_path}",
#             "cd #{current_path}",
#             "test -s #{unicorn_pid} && kill -USR2 `cat #{unicorn_pid}` || RAILS_ENV=#{rails_env} bundle exec unicorn_rails -D -c #{current_path}/config/unicorn.rb"
#         ].join(" && ")
#   end

# end

namespace :rvm do
  task :trust_rvmrc do
    run "rvm rvmrc trust #{release_path}"
  end
end

namespace :remote do
  desc "Run a task on a remote server."
  # run like: cap staging remote:invoke task=a_certain_task
  task :invoke do
    run "cd #{current_path}; RAILS_ENV=#{rails_env} bundle exec rake #{ENV['task']}"
  end
end

# after "deploy:setup", :create_sockets_dir
# after "deploy:update_code", :symlink_sockets
# after "deploy:create_symlink", :write_deploy_version
# before "deploy:assets:precompile", :cp_setting_files
# before "deploy:restart", :run_migrate_task
# set :whenever_command, "bundle exec whenever"
# require "whenever/capistrano"
