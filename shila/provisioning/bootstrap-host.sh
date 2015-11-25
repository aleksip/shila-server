#!/usr/bin/env bash

export CONF_ROOT=/vagrant/provisioning/conf
export DEBIAN_FRONTEND=noninteractive

##
# Install software
##

apt-get update

# MySQL
apt-get -y install mysql-server mysql-client

# PHP FPM + APC
apt-get -y install php5-fpm php5-mysql php5-cli php5-gd php-apc

# Nginx
apt-get -y install nginx

# Varnish
apt-get -y install apt-transport-https
curl https://repo.varnish-cache.org/GPG-key.txt | apt-key add -
echo "deb https://repo.varnish-cache.org/debian/ jessie varnish-4.1" >> /etc/apt/sources.list.d/varnish-cache.list
apt-get update
apt-get -y install varnish

# Git
apt-get -y install git

# Composer and Drush dependencies
apt-get -y install curl unzip

# Composer
curl -sS https://getcomposer.org/installer | php
mv composer.phar /usr/local/bin/composer

# Drush
wget -nv https://github.com/drush-ops/drush/releases/download/8.0.0/drush.phar
chmod +x drush.phar
mv drush.phar /usr/local/bin/drush

# Ruby + Bundler
apt-get -y install ruby
apt-get -y install ruby-dev
gem install bundler

# Other required packages
apt-get -y install php5-curl

##
# Configuration
##

# Nginx
rm /etc/nginx/sites-enabled/default
ln -fs ${CONF_ROOT}/etc/nginx/nginx.conf /etc/nginx/nginx.conf
ln -fs ${CONF_ROOT}/etc/nginx/dev-nginx-drupal8 /etc/nginx/dev-nginx-drupal8
ln -fs ${CONF_ROOT}/etc/nginx/prod-nginx-drupal8 /etc/nginx/prod-nginx-drupal8
ln -fs ${CONF_ROOT}/etc/nginx/dev-nginx-drupal7 /etc/nginx/dev-nginx-drupal7
ln -fs ${CONF_ROOT}/etc/nginx/prod-nginx-drupal7 /etc/nginx/prod-nginx-drupal7
ln -fs ${CONF_ROOT}/etc/nginx/sites-available/shila /etc/nginx/sites-available/shila
ln -fs /etc/nginx/sites-available/shila /etc/nginx/sites-enabled/shila

# Varnish
ln -fs ${CONF_ROOT}/etc/varnish/default.vcl /etc/varnish/default.vcl
ln -fs ${CONF_ROOT}/etc/default/varnish /etc/default/varnish
ln -fs ${CONF_ROOT}/etc/systemd/system/varnish.service /etc/systemd/system/varnish.service
systemctl daemon-reload
systemctl restart varnish.service

##
# Vagrant specific configuration
##

# Mount script for starting services
cp ${CONF_ROOT}/etc/init/vagrant-mounted.conf /etc/init/vagrant-mounted.conf

# Nicer default shell for vagrant user
chsh -s /bin/bash vagrant

# Prepare instance directory
mkdir -p /vagrant/instances/shila-dev
ln -fs /vagrant/instances/shila-dev /var/www/shila-dev
