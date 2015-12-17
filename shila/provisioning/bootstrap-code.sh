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
