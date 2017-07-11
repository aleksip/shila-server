#!/usr/bin/env bash

MY_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source ${MY_DIR}/scripts.conf

# Prepare directories
mkdir -p ${CODE_DIR}

# Shila Drupal
cd ${CODE_DIR}
if [ -d shila-drupal ]; then
  cd shila-drupal
  git pull
else
  git clone -b ${SHILA_DRUPAL_BRANCH} ${SHILA_DRUPAL_REPO} shila-drupal
fi
${CODE_DIR}/shila-drupal/scripts/bootstrap-code.sh
