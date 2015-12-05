#!/usr/bin/env bash

MY_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source ${MY_DIR}/scripts.conf

# Mount script for starting services
cp ${CONF_ROOT}/etc/init/vagrant-mounted.conf /etc/init/vagrant-mounted.conf

# Nicer default shell for vagrant user
chsh -s /bin/bash vagrant
