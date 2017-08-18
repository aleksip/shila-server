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
curl -sSL https://deb.nodesource.com/setup_6.x | bash -
apt-get install -y nodejs
npm install -g npm@latest

# Gulp
npm install -g gulp


################################################################################
# Configuration
################################################################################

# Xdebug
ln -fs ${CONF_ROOT}/etc/php/7.0/mods-available/xdebug.ini /etc/php/7.0/mods-available/xdebug.ini

# PHP 5.6
ln -sf ${CONF_ROOT}/etc/php/5.6/fpm/php.ini /etc/php/5.6/fpm/php.ini
ln -sf ${CONF_ROOT}/etc/php/5.6/fpm/pool.d/www.conf /etc/php/5.6/fpm/pool.d/www.conf
