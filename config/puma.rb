workers Integer(ENV['WEB_CONCURRENCY'] || 2)
threads_count = Integer(ENV['MAX_THREADS'] || 5)
threads threads_count, threads_count

preload_app!

rackup      DefaultRackup
port        ENV['PORT']     || 3000
environment ENV['RACK_ENV'] || 'development'

# Hacking in http://stackoverflow.com/questions/35140507/heroku-error-for-postgis-column-in-web-dyno-but-not-in-one-off-or-worker-dynos
on_worker_boot do
  if defined?(ActiveRecord::Base)
    config = ActiveRecord::Base.configurations[Rails.env] ||
      Rails.application.config.database_configuration[Rails.env]
    config['adapter'] = 'postgis'
    ActiveRecord::Base.establish_connection(config)
  end
end

on_restart do
  if defined?(ActiveRecord::Base)
    config = ActiveRecord::Base.configurations[Rails.env] ||
      Rails.application.config.database_configuration[Rails.env]
    config['adapter'] = 'postgis'
    ActiveRecord::Base.establish_connection(config)
  end
end
