# set path to application
app_dir = "/home/ubuntu/project"
shared_dir = "/home/ubuntu"
working_directory app_dir


# set unicorn options
worker_processes 2
preload_app true
timeout 30


# set up socket location
listen "/tmp/unicorn.sock", :backlog => 64


# logging
stderr_path "#{shared_dir}/unicorn.stderr.log"
stdout_path "#{shared_dir}/unicorn.stdout.log"


# set master PID location
pid "#{shared_dir}/unicorn.pid"
