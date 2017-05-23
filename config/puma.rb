bind_port = ENV['PORT'] || 8080
bind "tcp://127.0.0.1:#{bind_port}"

workers 2
threads 2, 8

environment ENV['RAILS_ENV'] || 'development'
worker_timeout 30
quiet true

prune_bundler

before_fork do
  require 'puma_worker_killer'
  PumaWorkerKiller.enable_rolling_restart
end

if ENV['APP_ROOT']
  directory ENV['APP_ROOT']
end
