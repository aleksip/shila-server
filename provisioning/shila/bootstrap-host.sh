#!/usr/bin/env bash

# shellcheck source=scripts-conf.sh
source "$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )/scripts-conf.sh"

source "${SCRIPTS_DIR}/functions.sh"

export DEBIAN_FRONTEND=noninteractive
timedatectl set-timezone "${TIMEZONE}"


################################################################################
# Install software
################################################################################

apt-get update

# Some common dependencies.
apt-get -y install unzip

# MySQL
debconf-set-selections <<< "mysql-server mysql-server/root_password password ${MYSQL_ROOT_PASSWORD}"
debconf-set-selections <<< "mysql-server mysql-server/root_password_again password ${MYSQL_ROOT_PASSWORD}"
apt-get -y install mysql-server mysql-client

# PHP 7.2
apt-get -y install php7.2-bcmath php7.2-bz2 php7.2-cli php7.2-curl php7.2-dev \
  php7.2-fpm php7.2-gd php7.2-geoip php7.2-imagick php7.2-intl php7.2-mbstring \
  php7.2-mysql php7.2-xml php7.2-zip

# Nginx
apt-get -y install nginx

# Composer
curl -sS https://getcomposer.org/installer | php
mv composer.phar /usr/local/bin/composer

# Drush 8
curl -sSLO https://github.com/drush-ops/drush/releases/download/8.3.0/drush.phar
mv drush.phar /usr/local/bin/drush
chmod +x /usr/local/bin/drush

# Drupal Console
curl -sS https://drupalconsole.com/installer -L -o drupal.phar
mv drupal.phar /usr/local/bin/drupal
chmod +x /usr/local/bin/drupal


################################################################################
# Configuration
################################################################################

# Nginx
ln -sf "${CONF_ROOT}/etc/nginx/nginx.conf" /etc/nginx/nginx.conf
ln -sf "${CONF_ROOT}/etc/nginx/nginx-drupal.conf" /etc/nginx/nginx-drupal.conf
ln -sf "${CONF_ROOT}/etc/nginx/nginx-drupal6.conf" /etc/nginx/nginx-drupal6.conf
if [ -d /etc/nginx/sites-available ]; then rm -rf /etc/nginx/sites-available; fi
ln -sf "${CONF_ROOT}/etc/nginx/sites-available" /etc/nginx/sites-available
if [ -h /etc/nginx/sites-enabled/default ]; then rm /etc/nginx/sites-enabled/default; fi
ln -sf /etc/nginx/sites-available/local/www.shila.test /etc/nginx/sites-enabled/www.shila.test
ln -sf /etc/nginx/sites-available/local/pl.shila.test /etc/nginx/sites-enabled/pl.shila.test

# Prepare instance directories.
shila_prepare_instance_dirs
