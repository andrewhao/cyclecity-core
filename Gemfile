source 'https://rubygems.org'

# Heroku uses the ruby version to configure your application's runtime.
ruby '2.3.0'

gem "mapbox-rails"
gem 'puma'
gem 'rack-canonical-host'
gem 'rails', '~> 4.2.0'
gem 'pg'
gem 'activerecord-postgis-adapter'
gem 'grape'
gem "gpx", require: "gpx"
gem "pry-byebug"
gem "pry"
gem "interactor"
gem "newrelic_rpm"
gem "stressfactor"
gem "filepicker_client", github: "infowrap/filepicker_client"
gem "dotenv"

gem "iron_worker_ng"
gem "faraday"
gem 'scenic'

gem 'slim-rails'
gem 'sass-rails'
gem 'bootstrap-sass'
gem 'jquery-rails'
gem 'coffee-rails'
gem 'simple_form'
gem 'uglifier'

gem 'awesome_print'

group :production, :acceptance do
  gem 'rails_stdout_logging'
  gem 'heroku_rails_deflate'
end

group :test do
  gem 'fuubar'
  gem 'capybara'
  #gem 'capybara-email'
  gem 'poltergeist'
  #gem 'timecop'
  gem 'database_cleaner'
  gem 'simplecov'
end

group :test, :development do
  gem 'rspec-rails'
  gem 'factory_girl_rails'
  gem 'jasmine-rails'
  #gem 'cane'
  #gem 'morecane'
end

group :development do
  gem "ruby-prof"
  gem 'spring'
  gem 'spring-commands-rspec'
  gem 'foreman'
  gem 'launchy'
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'quiet_assets'
  gem 'guard', '~> 2'
  gem 'guard-rspec'
  gem 'guard-livereload'
  gem 'rb-fsevent'
  gem 'growl'
end
