FROM ruby:2.3

RUN sed -i -e 's/deb.debian.org/archive.debian.org/g' \
           -e 's|security.debian.org|archive.debian.org|g' \
           -e '/stretch-updates/d' /etc/apt/sources.list
           
RUN apt-get update && apt-get install -y --allow-unauthenticated \
  nodejs \
  libsqlite3-dev \
  libssl-dev \
  ncurses-bin \
  && rm -rf /var/lib/apt/lists/*

ENV BUNDLE_PATH /var/tmp/pool_ruby_gems

RUN gem install bundler -v 1.17.3

WORKDIR /myapp

COPY . /myapp
