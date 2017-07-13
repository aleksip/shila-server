#!/usr/bin/env bash

MY_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source ${MY_DIR}/scripts.conf

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

# PHP 7.0
apt-get -y install php7.0-fpm php7.0-mysql php7.0-cli php7.0-gd php7.0-curl php7.0-mbstring php7.0-xml php7.0-zip

# PHP 5.6
add-apt-repository ppa:ondrej/php
apt-get update
apt-get -y install php5.6-fpm php5.6-mysql php5.6-cli php5.6-gd php5.6-curl

# Nginx
apt-get -y install nginx

# Varnish
apt-get -y install varnish

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
curl -sSL https://deb.nodesource.com/setup_6.x | bash -
apt-get install -y nodejs

# Gulp
npm install -g gulp


################################################################################
# Configuration
################################################################################

# PHP 5.6
ln -sf ${CONF_ROOT}/etc/php/5.6/fpm/php.ini /etc/php5/fpm/php.ini
ln -sf ${CONF_ROOT}/etc/php/5.6/fpm/pool.d/www.conf /etc/php5/fpm/pool.d/www.conf

# Nginx
ln -sf ${CONF_ROOT}/etc/nginx/nginx.conf /etc/nginx/nginx.conf
ln -sf ${CONF_ROOT}/etc/nginx/nginx-drupal /etc/nginx/nginx-drupal
ln -sf ${CONF_ROOT}/etc/nginx/nginx-drupal6 /etc/nginx/nginx-drupal6
rm -rf /etc/nginx/sites-available
ln -sf ${CONF_ROOT}/etc/nginx/sites-available /etc/nginx/sites-available
rm /etc/nginx/sites-enabled/default
ln -sf /etc/nginx/sites-available/local/www.shila.dev /etc/nginx/sites-enabled/www.shila.dev
ln -sf /etc/nginx/sites-available/local/pl.shila.dev /etc/nginx/sites-enabled/pl.shila.dev

# Varnish
ln -sf ${CONF_ROOT}/etc/varnish/default.vcl /etc/varnish/default.vcl
ln -sf ${CONF_ROOT}/etc/default/varnish /etc/default/varnish
ln -sf ${CONF_ROOT}/etc/systemd/system/varnish.service /etc/systemd/system/varnish.service

# Prepare instance directories
mkdir -p ${INSTANCE_DIR}
test ${OWNER_USER} != ${VAGRANT_USER} && (chown -R ${OWNER_USER}:${OWNER_USER} ${INSTANCES_ROOT})
ln -sf ${INSTANCE_DIR} ${SHILA_ROOT}
