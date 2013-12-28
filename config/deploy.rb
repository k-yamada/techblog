set :application, 'techblog'

set :repo_url, 'https://github.com/k-yamada/techblog.git'

# ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }

set :deploy_to, '/var/www/techblog'
set :scm, :git

set :rbenv_type, :user # or :system, depends on your rbenv setup
set :rbenv_ruby, '2.0.0-p247'
set :rbenv_prefix, "RBENV_ROOT=#{fetch(:rbenv_path)} RBENV_VERSION=#{fetch(:rbenv_ruby)} #{fetch(:rbenv_path)}/bin/rbenv exec"
set :rbenv_map_bins, %w{rake gem bundle ruby rails}
set :rbenv_roles, :all # default value

# set :format, :pretty
# set :log_level, :debug
# set :pty, true

# set :linked_files, %w{config/database.yml}
# set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

set :default_env, {
  'PATH' => "~/.rbenv/shims:~/.rbenv/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:$PATH",
}
# set :keep_releases, 5

namespace :deploy do

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      within release_path do
        execute :bundle, :install, '--deployment'
        #execute :rake, 'assets:precompile'
        #execute :touch, 'tmp/restart.txt'
      end

      #execute "echo $PATH"
      #execute "cd #{release_path} && bundle install"
      p "=========="
      p rbenv_prefix
      p "=========="
      # Your restart mechanism here, for example:
      # execute :touch, release_path.join('tmp/restart.txt')
      #execute "cd #{release_path} && bundle exec thor unicorn:restart"
    end
  end

  #after :restart, :clear_cache do
  #  on roles(:web), in: :groups, limit: 3, wait: 10 do
  #    # Here we can do anything such as:
  #    # within release_path do
  #    #   execute :rake, 'cache:clear'
  #    # end
  #  end
  #end

  after :finishing, 'deploy:cleanup'


end
