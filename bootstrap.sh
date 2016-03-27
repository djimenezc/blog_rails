#!/usr/bin/env bash

#apt-get update
#apt-get install -y apache2
#if ! [ -L /var/www ]; then
#  rm -rf /var/www
#  ln -fs /vagrant /var/www
#fi

echo "Executing bootstrap script"

gem update --no-rdoc --no-ri
#sudo apt-get install build-essential zlib1g-dev git-core
#gem install ohai --no-rdoc --no-ri --verbose