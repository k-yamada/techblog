# -*- coding: utf-8 -*-

require 'thor'

# USAGE
# -------------
# $ thor unicorn:start
# $ thor unicorn:stop
# $ thor unicorn:restart # graceful restart
# $ thor unicorn:hup     # reload setting

class Unicorn < Thor
  ROOT = File.expand_path('../', __FILE__)

  desc "start", 'unicorn start'
  def start
    ENV['RAILS_ENV'] = "production" unless ENV['RAILS_ENV']
    # see: http://blog.twiwt.org/e/2e6270
    exec_cmd({"BUNDLE_GEMFILE"=>"#{ROOT}/Gemfile"}, "bundle exec unicorn -c config/unicorn/#{ENV['RAILS_ENV']}.rb -E #{ENV['RAILS_ENV']} -D")
  end

  desc "stop", 'Graceful shutdown (Send signal QUIT to master process).'
  def stop
    send_signal_to_unicorn(unicorn_pid, :QUIT)
  end

  # graceful restart(zero downtime restart)
  desc "restart", "restart"
  def restart
    if unicorn_pid
      send_signal_to_unicorn(unicorn_pid,     :USR2)
      sleep 10
      send_signal_to_unicorn(unicorn_old_pid, :WINCH)
      send_signal_to_unicorn(unicorn_old_pid, :QUIT)
    else
      invoke :start
    end
  end

  desc "force_restart", "force_restart"
  def force_restart
    if unicorn_pid
      send_signal_to_unicorn(unicorn_pid,     :QUIT)
    end
    invoke :start
  end

  desc "hup", 'hup'
  def hup
    send_signal_to_unicorn(unicorn_pid, :HUP)
  end

  private

  def unicorn_pid
    path = "/tmp/techblog.pid"
    if File.exists? path
      `cat /tmp/techblog.pid`.chomp
    else
      false
    end
  end

  def unicorn_old_pid
    `cat /tmp/techblog.pid.oldbin`.chomp
  end

  def send_signal_to_unicorn(pid, signal, failed_message='Not running.')
    if pid
      exec_cmd "kill -#{signal.to_s} #{pid}"
    else
      puts failed_message if failed_message.present?
    end
  end

  def exec_cmd(env={}, cmd)
    p cmd
    system(env, cmd)
  end
end
