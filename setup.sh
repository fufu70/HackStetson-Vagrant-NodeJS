#!/bin/bash

# Updating Box

sudo apt-get -y update

# Installing nodejs
sudo apt-get -y install nodejs

# Install package manage
sudo apt-get -y install npm

sudo apt-get -y install cowsay

# Get the ip address to display
IP_ADDRESS=$(ifconfig eth1 | grep 'inet addr' | cut -d ':' -f 2 | cut -d ' ' -f 1)

echo "The cow says that you can access your server by entering this IP in your browser: ${IP_ADDRESS}:8080  ... that is after you start your node server" | cowsay