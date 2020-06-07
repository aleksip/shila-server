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

# PHP 7.4
add-apt-repository -y ppa:ondrej/php
apt-get update
apt-get -y install php7.4-bcmath php7.4-bz2 php7.4-cli php7.4-curl php7.4-dev \
  php7.4-fpm php7.4-gd php7.4-geoip php7.4-imagick php7.4-intl php7.4-mbstring \
  php7.4-mysql php7.4-xml php7.4-zip

# Nginx
apt-get -y install nginx

# Composer
curl -sS https://getcomposer.org/installer | php
mv composer.phar /usr/local/bin/composer


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
