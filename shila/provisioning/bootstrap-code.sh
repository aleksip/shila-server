#!/usr/bin/env bash

MY_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source ${MY_DIR}/scripts.conf

# Prepare directories
sudo mkdir -p ${INSTANCE_DIR}
sudo ln -fs ${INSTANCE_DIR} ${SHILA_ROOT}
mkdir -p ${SHILA_ROOT}/code

# Shila Drupal
cd ${SHILA_ROOT}/code
(cd shila-drupal && git pull) || git clone -b ${SHILA_BRANCH} https://github.com/aleksip/shila-drupal
${SHILA_ROOT}/code/shila-drupal/scripts/bootstrap-code.sh

# Pattern Lab
cd ${SHILA_ROOT}/code
(cd patternlab-php && git pull) || git clone https://github.com/pattern-lab/patternlab-php
rm -rf ${SHILA_ROOT}/code/patternlab-php/source
ln -fs ${SHILA_ROOT}/code/shila-drupal/d8/web/sites/shila.dev/themes/shila_theme ${SHILA_ROOT}/code/patternlab-php/source
cd ${SHILA_ROOT}/code/patternlab-php
php core/builder.php -g
