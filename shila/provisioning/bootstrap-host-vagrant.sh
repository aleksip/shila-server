#!/usr/bin/env bash

MY_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source ${MY_DIR}/scripts.conf


################################################################################
# Install software
################################################################################

# Xdebug
apt-get -y install php7.0-xdebug


################################################################################
# Configuration
################################################################################

# Nicer default shell for vagrant user
chsh -s /bin/bash vagrant

# Xdebug
ln -fs ${CONF_ROOT}/etc/php/7.0/mods-available/xdebug.ini /etc/php/7.0/mods-available/xdebug.ini
