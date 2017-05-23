require "bundler/capistrano"
require 'procodile/capistrano2'

load 'deploy'
load 'deploy/assets'

## The repository from which you wish to deploy your application
## from should be entered here.
set :repository, "git@codebasehq.com:phoenixdev/elfkit/elfkit.git"

# General
set :application,         "elfkit"
set :domain,              "elfk.it"
set :user,                "dan"
set :use_sudo,            false
set :deploy_to,           "/opt/rails/elfkit"
set :repository_cache,    "#{application}_cache"
set :environment,         "production"
set :assets_role,         [:app]

# GIT
set :branch,              "master"
set :keep_releases,       3
set :deploy_via,          :remote_cache
set :scm,                 :git

# SSH
default_run_options[:pty] = true
ssh_options[:forward_agent] = true
ssh_options[:paranoid] = true # comment out if it gives you trouble. newest net/ssh needs this set.

role :app, "danw.infra.atech.io"
role :db, "danw.infra.atech.io", :primary => true

set :config_files, ['database.yml']

namespace :deploy do
  desc 'Symlink configuration files into new application'
  task :symlink_config do
    commands = fetch(:config_files, []).map do |file|
      "ln -s #{shared_path}/config/#{file} #{release_path}/config/#{file}"
    end.join(' && ')
    run commands

    run "ln -s #{shared_path}/Procfile.local #{release_path}/Procfile.local"
  end

  desc 'Symlink a shared cache folder'
  task :symlink_cache do
    run "mkdir -p #{shared_path}/rails-cache && rm -Rf #{release_path}/tmp/cache && ln -s #{shared_path}/rails-cache #{release_path}/tmp/cache"
  end
end

after "deploy:update_code", "deploy:symlink_config"
after "deploy:update_code", "deploy:symlink_cache"
