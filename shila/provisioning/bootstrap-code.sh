#!/usr/bin/env bash

MY_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source ${MY_DIR}/scripts.conf

# Prepare directories
mkdir -p ${INSTANCE_DIR}
ln -fs ${INSTANCE_DIR} ${SHILA_ROOT}
mkdir -p ${CODE_DIR}

# Shila Drupal
cd ${CODE_DIR}
(cd shila-drupal && git pull) || git clone -b ${SHILA_BRANCH} https://github.com/aleksip/shila-drupal
${CODE_DIR}/shila-drupal/scripts/bootstrap-code.sh

# Pattern Lab
cd ${CODE_DIR}
(cd patternlab-php && git pull) || git clone https://github.com/pattern-lab/patternlab-php
rm -rf ${CODE_DIR}/patternlab-php/source
ln -fs ${CODE_DIR}/shila-drupal/d8/web/sites/shila.dev/themes/shila_theme ${CODE_DIR}/patternlab-php/source
cd ${CODE_DIR}/patternlab-php
php core/builder.php -g
