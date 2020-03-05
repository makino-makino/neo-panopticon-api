FROM ruby:2.5.3

RUN apt-get update -qq && \
    apt-get install -y build-essential libpq-dev nodejs           

RUN mkdir /api
WORKDIR /api

ADD ./Gemfile /api/Gemfile
#ADD ./Gemfile.lock /api/Gemfile.lock

RUN bundle update && \
    bundle install --clean

RUN apt-get install -y vim mysql-client
