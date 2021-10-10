#!/bin/bash

bundle check || bundle install

rm -f tmp/pids/server.pid

bundle exec rails server -b 0.0.0.0
