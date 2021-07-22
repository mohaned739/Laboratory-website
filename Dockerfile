FROM ruby:2.6.7
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev
WORKDIR /GP
RUN gem install bundler:2.2.20
COPY Gemfile /GP/Gemfile
COPY Gemfile.lock /GP/Gemfile.lock
RUN bundle install
RUN rails db:create
RUN rails db:migrate
COPY .. /GP
CMD ["rails", "server", "-b", "0.0.0.0"]