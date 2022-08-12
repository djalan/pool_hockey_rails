FROM bitnami/ruby:2.2

RUN apt-get update && apt-get install -y \
  nodejs \
  libsqlite3-dev \
  libssl-dev \
  ncurses-bin \
  && rm -rf /var/lib/apt/lists/*

ENV BUNDLE_PATH /var/tmp/pool_ruby_gems

RUN gem install bundler -v 1.17.3

WORKDIR /myapp

COPY . /myapp
