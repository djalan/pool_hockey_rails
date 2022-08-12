#!/bin/bash

bundle check || bundle install

rm -f tmp/pids/server.pid

bundle exec puma -b 'ssl://0.0.0.0:3000?key=/var/tmp/djalan.hopto.org/privkey.pem&cert=/var/tmp/djalan.hopto.org/fullchain.pem'

# without certificate, defaults to port 9292
# bundle exec puma
