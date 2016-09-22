worker_processes Integer(ENV["WEB_CONCURRENCY"] || 1)
timeout 60
preload_app true

before_fork do |server, worker|
  Signal.trap 'TERM' do
    puts 'Unicorn master intercepting TERM and sending myself QUIT instead'
    Process.kill 'QUIT', Process.pid
  end

  defined?(ActiveRecord::Base) and
    ActiveRecord::Base.connection.disconnect!
end

after_fork do |server, worker|
  Signal.trap 'TERM' do
    puts 'Unicorn worker intercepting TERM and doing nothing. Wait for master to send QUIT'
  end

  defined?(ActiveRecord::Base) and
    ActiveRecord::Base.establish_connection
end

# 標準出力ログ出力先
stdout_path "log/unicorn.stdout.log"
# 標準エラー出力ログ出力先
stderr_path "log/unicorn.stderr.log"

GC.respond_to?(:copy_on_write_friendly=) and GC.copy_on_write_friendly = true
