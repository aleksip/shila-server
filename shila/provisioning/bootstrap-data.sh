#!/usr/bin/env bash

MY_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source ${MY_DIR}/scripts.conf

# Shila Drupal
${SHILA_ROOT}/code/shila-drupal/scripts/bootstrap-data.sh
