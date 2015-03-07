# config valid only for Capistrano 3.1
# lock '3.2.1'

# set :application, 'my_app_name'
# set :repo_url, 'git@example.com:me/my_repo.git'

# Default branch is :master
# ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }.call

# Default deploy_to directory is /var/www/my_app
# set :deploy_to, '/var/www/my_app'

# Default value for :scm is :git
# set :scm, :git

# Default value for :format is :pretty
# set :format, :pretty

# Default value for :log_level is :debug
# set :log_level, :debug

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
# set :linked_files, %w{config/database.yml}

# Default value for linked_dirs is []
# set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
# set :keep_releases, 5

# namespace :deploy do

  # desc 'Restart application'
  # task :restart do
    # on roles(:app), in: :sequence, wait: 5 do
      # Your restart mechanism here, for example:
      # execute :touch, release_path.join('tmp/restart.txt')
    # end
  # end

  # after :publishing, :restart

  # after :restart, :clear_cache do
    # on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    # end
  # end

# end

lock '3.2.1'

set :application, 'readerd'
set :repo_url, 'git@github.com:shimizu-daisuke/readerd.git'


set :deploy_to, '/home/rails/readerd'
set :branch, 'master'
set :keep_releases, 5

set :scm, :git
set :log_level, :debug
set :pty, true

set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets bundle public/system public/assets vendor/bundle}
set :unicorn_pid, "#{shared_path}/tmp/pids/unicorn.pid"
#set :unicorn_pid, "#{shared_path}/current/tmp/pids/unicorn.pid"
#set :default_env, { path: "/usr/local/src/rbenv/shims:/usr/local/src/rbenv/bin:$PATH" }

#set :rbenv_path, '/usr/local/src/rbenv'
set :rbenv_ruby, '2.0.0'

set :bundle_jobs, 4

set :bundle_flags, "--quiet"

after 'deploy:publishing', 'deploy:restart'
namespace :deploy do
  desc 'Restart application'
  task :restart do
    on roles(:readerd) do
      execute "cd /home/rails/readerd/current ; bundle exec rake generate_secret_token:generate"
      execute "kill -s USR2 `cd /home/rails/readerd/current ; cat tmp/pids/unicorn.pid`"
    end
  end
  after :finishing, 'deploy:cleanup'
end
