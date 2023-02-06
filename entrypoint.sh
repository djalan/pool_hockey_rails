#!/bin/bash

bundle check || bundle install

rm -f tmp/pids/server.pid

if [[ $DJ_IP == $WAN_IP && $MY_DOCKER_HOST == "fedora-black" ]]; then
    PARAMS="ssl://0.0.0.0:3000"
    PARAMS+="?key=/var/tmp/${MY_URL}/privkey.pem"
    PARAMS+="&cert=/var/tmp/${MY_URL}/cert.pem"
    bundle exec puma -b $PARAMS
else
    # default port: 9292
    bundle exec puma
fi
