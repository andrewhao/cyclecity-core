FROM ruby:2.3.0-slim
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs npm nodejs-legacy vim git-core libgeos-dev libproj-dev
RUN npm install -g phantomjs

RUN mkdir /velocitas-core

WORKDIR /tmp
COPY Gemfile Gemfile
COPY Gemfile.lock Gemfile.lock
RUN bundle install

ADD . /velocitas-core
WORKDIR /velocitas-core
RUN RAILS_ENV=production bundle exec rake assets:precompile --trace
CMD ["rails","server","-b","0.0.0.0"]
