#!/usr/bin/env bash

MY_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source ${MY_DIR}/scripts-conf.sh

export DEBIAN_FRONTEND=noninteractive


################################################################################
# Install software
################################################################################

# Xdebug
apt-get -y install php-xdebug

# PHP 5.6
add-apt-repository ppa:ondrej/php
apt-get update
apt-get -y install php5.6-fpm php5.6-mysql php5.6-cli php5.6-gd php5.6-curl php5.6-xml

# Node.js + npm
curl -sSL https://deb.nodesource.com/setup_10.x | bash -
apt-get install -y nodejs
apt-get install -y build-essential

# Gulp
npm install -g gulp-cli


################################################################################
# Configuration
################################################################################

# PHP 5.6
ln -sf ${CONF_ROOT}/etc/php/5.6/fpm/php.ini /etc/php/5.6/fpm/php.ini
ln -sf ${CONF_ROOT}/etc/php/5.6/fpm/pool.d/www.conf /etc/php/5.6/fpm/pool.d/www.conf

# Ubuntu user
ln -sf ${CONF_ROOT}/home/ubuntu/.bash_aliases /home/ubuntu/.bash_aliases
