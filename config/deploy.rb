# config valid for current version and patch releases of Capistrano
lock "~> 3.15.0"

set :application, "lca-auftragsliste"
set :repo_url, "git@github.com:moritzdotcom/lca-auftragsliste.git"

# set :rbenv_type, :user # or :system, or :fullstaq (for Fullstaq Ruby), depends on your rbenv setup
# set :rbenv_ruby, '2.7.0'

# set :rbenv_prefix, "RBENV_ROOT=#{fetch(:rbenv_path)} RBENV_VERSION=#{fetch(:rbenv_ruby)} #{fetch(:rbenv_path)}/bin/rbenv exec"
# set :rbenv_map_bins, %w{rake gem bundle ruby rails}
# set :rbenv_roles, :all # default value

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
set :deploy_to, "/home/deploy/#{fetch :application}"

append :linked_dirs, 'log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', '.bundle', 'public/system', 'public/uploads'
append :linked_files, 'config/master.key', 'config/lca_app_config.rb'

# Only keep the last 5 releases to save disk space
set :keep_releases, 5

set :rails_env, :production
set :passenger_restart_with_touch, true
set :ssh_options, forward_agent: true
set :git_shallow_clone, 1
