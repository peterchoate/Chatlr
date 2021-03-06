#!/bin/sh

# Chatlr Install Script for Ubuntu

# Get the essentials
apt-get update
apt-get install git-core build-essential libssl-dev

# Install node.js
cd /usr/src
git clone https://github.com/joyent/node
cd node
git checkout v0.4
./configure
make
make install

# Install NPM (Node Package Manager)
curl http://npmjs.org/install.sh | clean=no sh

# Install Forever
npm -g install express connect socket.io forever

# install Chatlr
cd /usr/src
git clone git://github.com/KevinNuut/Chatlr.git

# Setup Chatlr
cd Chatlr
git checkout dev
git submodule update --init --recursive

# Copy config.js.bu and replace all of the open variables with user input
sed -e "s/CHATLR_DOMAIN/$1/" -e "s/TUMBLR_CONSUMER_KEY/$2/" -e "s/TUMBLR_CONSUMER_SECRET/$3/" -e "s/TUMBLR_USERNAME/$4/" -e "s/SESSION_SECRET/$5/" config/config.js.bu >> config/config.js

# Run the Chatlr script and output errors to out.log
forever start chatlr.js
