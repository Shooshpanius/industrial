set :application, "corp"
set :repository,  "https://github.com/Shooshpanius/industrial"

set :scm, "git"
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

set :user, 'industrial' # пользователь удалённого сервера
set :use_sudo, false # не запускать команды под sudo

set :deploy_to, "/home/industrial/www/industrial"
set :shared_path, "/home/industrial/www/industrial/shared"
server "192.168.2.38", :app, :web, :db, :primary => true

set :keep_releases, 5
set :deploy_via, :remote_cache

set :unicorn_conf, "#{deploy_to}/current/config/unicorn.rb"
set :unicorn_pid, "#{deploy_to}/current/tmp/pids/unicorn.pid"
set :rails_env, "production"

require 'unicorn_service'
set :application, 'industrial'
set :user, 'industrial'
set :deploy_to, '/home/industrial/www/industrial'

namespace :deploy do
  task :start, :roles => :app do
    run "touch #{current_release}/tmp/restart.txt"
    # run "cp #{current_release} #{deploy_to}/current"
  end

  task :stop, :roles => :app do

  end

  desc "Update Bundles"
  task :bundles, :roles => :app do
    run "cd #{deploy_to}/current &&  bundle install --without test development win"
  end

  desc "Db Migrate"
  task :migrate, :roles => :app do
    run "cd #{deploy_to}/current &&  rake environment RAILS_ENV=production db:migrate"
  end

  desc "Sitemap Gen"
  task :refresh_sitemaps , :roles => :app do
    #run "cd #{deploy_to}/current && rake environment RAILS_ENV=production sitemap:refresh"
  end

  desc "Clear DB"
  task :clear_db , :roles => :app do
    #run "cd #{deploy_to}/current && rake environment RAILS_ENV=production clear_db:vacancy"
  end


  task :precompile_assets, :roles => :app do
    run "cd #{deploy_to}/current && RAILS_ENV=production rake assets:precompile"
  end

  namespace :thin do
    task :restart do
      run "if [ -f #{unicorn_pid} ] && [ -e /proc/$(cat #{unicorn_pid}) ]; then kill -USR2 `cat #{unicorn_pid}`; else cd #{deploy_to}/current && bundle exec unicorn_rails -c #{unicorn_conf} -E #{rails_env} -D; fi"
    end
    task :start do
      run "bundle exec unicorn_rails -c #{unicorn_conf} -E #{rails_env} -D"
    end
    task :stop do
      run "if [ -f #{unicorn_pid} ] && [ -e /proc/$(cat #{unicorn_pid}) ]; then kill -QUIT `cat #{unicorn_pid}`; fi"
    end
  end

  desc "Restart Application"
  task :restart, :roles => :app do
    run "touch #{current_release}/tmp/restart.txt"
  end

  desc "Regenerate css with Sass and package assets with Jammit"
  task :package_assets, :roles => :app do
    # Add `gem 'sass'` in your gemfile.rb if no task sass:update
    # run "RAILS_ENV=production cd #{deploy_to}/current && rake sass:update && jammit"
  end

  task :link_dependencies, :roles => :app do
    run "ln -nfs #{shared_path}/attache #{deploy_to}/current/public"
    run "ln -nfs #{shared_path}/files #{deploy_to}/current/public"
    #run "ln -nfs #{shared_path}/attache #{deploy_to}/current/public"
    #run "ln -nfs #{shared_path}/public/images/posts #{release_path}/public/images/posts"
  end


end

#after "deploy:update", "deploy:cleanup", "deploy:bundles", "deploy:migrate", "deploy:thin:restart", "deploy:clear_db", "deploy:refresh_sitemaps", "deploy:precompile_assets"
after "deploy:update", "deploy:cleanup", "deploy:bundles", "deploy:migrate", "deploy:clear_db", "deploy:refresh_sitemaps", "deploy:precompile_assets" , "deploy:link_dependencies" , "deploy:thin:restart"
before "deploy:stop","deploy:start", "deploy:package_assets"
#before "deploy:restart", "deploy:package_assets"