#!/usr/bin/env bash

MY_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source ${MY_DIR}/scripts.conf
export DEBIAN_FRONTEND=noninteractive


################################################################################
# Install software
################################################################################

apt-get update

# Some common dependencies
apt-get -y install curl unzip

# MySQL
apt-get -y install mysql-server mysql-client

# PHP FPM + APC
apt-get -y install php5-fpm php5-mysql php5-cli php5-gd php-apc

# Nginx
apt-get -y install nginx

# Varnish
apt-get -y install apt-transport-https
curl -sS https://repo.varnish-cache.org/GPG-key.txt | apt-key add -
echo "deb https://repo.varnish-cache.org/debian/ jessie varnish-4.1" >> /etc/apt/sources.list.d/varnish-cache.list
apt-get update
apt-get -y install varnish

# Git
apt-get -y install git

# Composer
curl -sS https://getcomposer.org/installer | php
mv composer.phar /usr/local/bin/composer

# Drush
wget -nv http://files.drush.org/drush.phar
chmod +x drush.phar
mv drush.phar /usr/local/bin/drush

# Drupal Console
curl -sS https://drupalconsole.com/installer -L -o drupal.phar
mv drupal.phar /usr/local/bin/drupal
chmod +x /usr/local/bin/drupal

# Node.js + npm
curl -sSL https://deb.nodesource.com/setup_5.x | bash -
apt-get install -y nodejs

# Gulp + Bower
npm install -g gulp bower

# Other required packages
apt-get -y install php5-curl


################################################################################
# Configuration
################################################################################

# Nginx
rm /etc/nginx/sites-enabled/default
ln -fs ${CONF_ROOT}/etc/nginx/nginx.conf /etc/nginx/nginx.conf
ln -fs ${CONF_ROOT}/etc/nginx/prod-nginx-drupal8 /etc/nginx/prod-nginx-drupal8
ln -fs ${CONF_ROOT}/etc/nginx/prod-nginx-drupal7 /etc/nginx/prod-nginx-drupal7
ln -fs ${CONF_ROOT}/etc/nginx/dev-nginx-drupal8 /etc/nginx/dev-nginx-drupal8
ln -fs ${CONF_ROOT}/etc/nginx/dev-nginx-drupal7 /etc/nginx/dev-nginx-drupal7
ln -fs ${CONF_ROOT}/etc/nginx/sites-available/shila /etc/nginx/sites-available/shila
ln -fs /etc/nginx/sites-available/shila /etc/nginx/sites-enabled/shila

# Varnish
ln -fs ${CONF_ROOT}/etc/varnish/default.vcl /etc/varnish/default.vcl
ln -fs ${CONF_ROOT}/etc/default/varnish /etc/default/varnish
ln -fs ${CONF_ROOT}/etc/systemd/system/varnish.service /etc/systemd/system/varnish.service

# Prepare instance directories
mkdir -p ${INSTANCE_DIR}
test ${OWNER_USER} != "vagrant" && (chown -R ${OWNER_USER}:${OWNER_USER} ${INSTANCES_DIR})
ln -fs ${INSTANCE_DIR} ${SHILA_ROOT}
