application = '/usr/local/www/apache24/www2033u/readerd'

worker_processes 2
working_directory "#{application}"
#working_directory "/home/rails/#{application}/current"

# Output Unix Domain Socket
listen "#{application}/tmp/sockets/unicorn.sock"

# Output PID File
pid "#{application}/tmp/pids/unicorn.pid"

timeout 60

preload_app true

# 標準出力ログ出力先
stdout_path "log/unicorn.stdout.log"
# 標準エラー出力ログ出力先
stderr_path "log/unicorn.stderr.log"

GC.respond_to?(:copy_on_write_friendly=) and GC.copy_on_write_friendly = true

before_fork do |server, worker|
  defined?(ActiveRecord::Base) and ActiveRecord::Base.connection.disconnect!

  old_pid = "#{server.config[:pid]}.oldbin"
    if old_pid != server.pid
      begin
        sig = (worker.nr + 1) >= server.worker_processes ? :QUIT : :TTOU
        Process.kill(sig, File.read(old_pid).to_i)
      rescue Errno::ENOENT, Errno::ESRCH
      end
    end

    sleep 1
  end

after_fork do |server, worker|
  defined?(ActiveRecord::Base) and ActiveRecord::Base.establish_connection
end
