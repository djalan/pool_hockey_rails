#!/bin/bash

source properties.private

echo "MY_URL=$MY_URL" | tee .env
echo "DJ_IP=$(dig $MY_URL +short)" | tee -a .env
echo "WAN_IP=$(curl -s https://icanhazip.com)" | tee -a .env
echo "MY_DOCKER_HOST=$HOSTNAME" | tee -a .env
