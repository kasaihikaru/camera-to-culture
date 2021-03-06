app_path = File.expand_path('../../', __FILE__)

worker_processes 1

working_directory "/home/ec2-user/work/camera-to-culture/current"
pid "/home/ec2-user/work/camera-to-culture/shared/tmp/pids/unicorn.pid"
stderr_path "/home/ec2-user/work/camera-to-culture/shared/log/unicorn.stderr.log"
stdout_path "/home/ec2-user/work/camera-to-culture/shared/log/unicorn.stdout.log"


listen 3000
timeout 60

preload_app true
GC.respond_to?(:copy_on_write_friendly=) && GC.copy_on_write_friendly = true
check_client_connection false

run_once = true

#env用に追加してみた
before_exec do |server|
  Dotenv.overload
end

before_fork do |server, worker|
  defined?(ActiveRecord::Base) &&
    ActiveRecord::Base.connection.disconnect!

  if run_once
    run_once = false # prevent from firing again
  end

  old_pid = "#{server.config[:pid]}.oldbin"

  if File.exist?(old_pid) && server.pid != old_pid
    begin
      sig = (worker.nr + 1) >= server.worker_processes ? :QUIT : :TTOU
      Process.kill(sig, File.read(old_pid).to_i)

    rescue Errno::ENOENT, Errno::ESRCH => e
      logger.error e
    end
  end
end

after_fork do |_server, _worker|
  defined?(ActiveRecord::Base) && ActiveRecord::Base.establish_connection
end