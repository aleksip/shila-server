#!/usr/bin/env bash

MY_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source ${MY_DIR}/scripts-conf.sh

export DEBIAN_FRONTEND=noninteractive
timedatectl set-timezone ${TIMEZONE}


################################################################################
# Install software
################################################################################

apt-get update

# Some common dependencies
apt-get -y install unzip

# MySQL
debconf-set-selections <<< "mysql-server mysql-server/root_password password ${MYSQL_ROOT_PASSWORD}"
debconf-set-selections <<< "mysql-server mysql-server/root_password_again password ${MYSQL_ROOT_PASSWORD}"
apt-get -y install mysql-server mysql-client

# PHP 7.2
apt-get -y install php7.2-bcmath php7.2-bz2 php7.2-cli php7.2-curl php7.2-dev php7.2-fpm php7.2-gd php7.2-geoip php7.2-imagick php7.2-intl php7.2-mbstring php7.2-mysql php7.2-xml php7.2-zip

# Nginx
apt-get -y install nginx

# Composer
curl -sS https://getcomposer.org/installer | php
mv composer.phar /usr/local/bin/composer

# Drush 8
wget -nv https://github.com/drush-ops/drush/releases/download/8.1.17/drush.phar
chmod +x drush.phar
mv drush.phar /usr/local/bin/drush

# Drupal Console
curl -sS https://drupalconsole.com/installer -L -o drupal.phar
mv drupal.phar /usr/local/bin/drupal
chmod +x /usr/local/bin/drupal


################################################################################
# Configuration
################################################################################

# Nginx
ln -sf ${CONF_ROOT}/etc/nginx/nginx.conf /etc/nginx/nginx.conf
ln -sf ${CONF_ROOT}/etc/nginx/nginx-drupal.conf /etc/nginx/nginx-drupal.conf
ln -sf ${CONF_ROOT}/etc/nginx/nginx-drupal6.conf /etc/nginx/nginx-drupal6.conf
rm -rf /etc/nginx/sites-available
ln -sf ${CONF_ROOT}/etc/nginx/sites-available /etc/nginx/sites-available
rm /etc/nginx/sites-enabled/default
ln -sf /etc/nginx/sites-available/local/www.shila.test /etc/nginx/sites-enabled/www.shila.test
ln -sf /etc/nginx/sites-available/local/pl.shila.test /etc/nginx/sites-enabled/pl.shila.test

# Prepare instance directories
mkdir -p ${INSTANCE_DIR}
test ${OWNER_USER} != ${VAGRANT_USER} && (chown -R ${OWNER_USER}:${OWNER_USER} ${INSTANCES_ROOT})
ln -sf ${INSTANCE_DIR} ${SHILA_ROOT}
