require "bundler/capistrano"
require 'new_relic/recipes'
set :whenever_command, "bundle exec whenever"
require 'whenever/capistrano'

server("CREDENTIALS", :app, :web, :db, { :primary => true })

set(:application, "halfapp")
set(:user, "CREDENTIALS")
set(:deploy_to, "/opt/#{application}")
set(:deploy_via, :remote_cache)
set(:use_sudo, false)

set(:scm, "git")
set(:repository, "git@github.com:sigeppenntheta/halfapp.git")
set(:branch, "master")

# Make rbenv work
set(:default_environment, { 'PATH' => "$HOME/.rbenv/shims:$HOME/.rbenv/bin:$PATH" })

# Don't try to do weird rails asset shit
# set(:normalize_asset_timestamps, false)

default_run_options[:pty] = true
ssh_options[:forward_agent] = true

before("deploy", "deploy:check_revision")
before('deploy:assets:precompile', 'deploy:setup_db_config')

after("deploy", "deploy:cleanup") # keep only the last 5 releases
after("deploy", "deploy:reload_nginx")
after("deploy:setup", "deploy:setup_config")

# NewRelic
after('deploy', 'newrelic:notice_deployment')
after('deploy:update', 'newrelic:notice_deployment')
after('deploy:migrations', 'newrelic:notice_deployment')
after('deploy:cold', 'newrelic:notice_deployment')

namespace :deploy do
  %w[start stop restart].each do |command|
    desc "#{command} unicorn server"
    task command do
      deploy.migrate
      run "sudo service unicorn_#{application} #{command == 'restart' ? 'upgrade' : command}"
    end
  end

  task :setup_config, roles: :app do
    run "sudo ln -nfs #{current_path}/config/nginx_halfapp.conf /etc/nginx/sites-enabled/#{application}"
    run "sudo ln -nfs #{current_path}/config/unicorn_init.sh /etc/init.d/unicorn_#{application}"

    run "mkdir -p #{shared_path}/log"
  end

  task :setup_db_config do
    transfer :up, "config/database.yml", "#{release_path}/config/database.yml"
    # transfer :up, "config/application.yml", "#{release_path}/config/application.yml"
    # run "cp #{release_path}/config/database.yml.sample #{release_path}/config/database.yml"
    transfer :up, "lib/tasks/brothers.csv", "#{release_path}/lib/tasks/brothers.csv"
    transfer :up, "config/newrelic.yml", "#{release_path}/config/newrelic.yml"
  end

  desc "Make sure local git is in sync with remote."
  task :check_revision do
    unless `git rev-parse HEAD` == `git rev-parse origin/master`
      puts "WARNING: HEAD is not the same as origin/master"
      puts "Run `git push` to sync changes."
      exit
    end
  end

  desc "Reload nginx config files"
  task :reload_nginx do
    # Reload configs, don't need to restart the server
    run "sudo service nginx reload"
  end
end
