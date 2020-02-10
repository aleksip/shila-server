#!/usr/bin/env bash

# shellcheck source=scripts-conf.sh
source "$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )/scripts-conf.sh"

export DEBIAN_FRONTEND=noninteractive


################################################################################
# Install software
################################################################################

# Xdebug
apt-get -y install php-xdebug

# PHP 7.2
apt-get -y install php7.2-sqlite

# PHP 5.6
add-apt-repository -y ppa:ondrej/php
apt-get update
apt-get -y install php5.6-fpm php5.6-mysql php5.6-cli php5.6-gd php5.6-curl php5.6-xml

# Node.js + npm
curl -sSL https://deb.nodesource.com/setup_10.x | bash -
apt-get install -y nodejs
apt-get install -y build-essential

# Gulp
npm install -g gulp-cli

# MailHog
curl -sSL https://github.com/mailhog/MailHog/releases/download/v1.0.0/MailHog_linux_amd64 -o mailhog
mv mailhog /usr/local/bin/mailhog
chmod +x /usr/local/bin/mailhog
apt-get install -y daemonize


################################################################################
# Configuration
################################################################################

# PHP 7.2 + Xdebug
ln -sf "${CONF_ROOT}/etc/php/7.2/fpm/php.ini" /etc/php/7.2/fpm/php.ini
ln -sf "${CONF_ROOT}/etc/php/7.2/mods-available/xdebug.ini" /etc/php/7.2/mods-available/xdebug.ini

# PHP 5.6 + Xdebug
ln -sf "${CONF_ROOT}/etc/php/5.6/fpm/php.ini" /etc/php/5.6/fpm/php.ini
ln -sf "${CONF_ROOT}/etc/php/5.6/fpm/pool.d/www.conf" /etc/php/5.6/fpm/pool.d/www.conf
ln -sf "${CONF_ROOT}/etc/php/5.6/mods-available/xdebug.ini" /etc/php/5.6/mods-available/xdebug.ini

# MailHog
ln -sf "${CONF_ROOT}/etc/init.d/mailhog" /etc/init.d/mailhog

# Ubuntu user
ln -sf "${CONF_ROOT}/home/ubuntu/.bash_aliases" /home/ubuntu/.bash_aliases

# Default to Xdebug off.
sudo "${SCRIPTS_DIR}/xoff.sh"
