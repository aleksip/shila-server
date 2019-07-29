#!/usr/bin/env bash

MY_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
# shellcheck source=./scripts.conf
source "${MY_DIR}/scripts-conf.sh"

# Shila Drupal
"${CODE_DIR}/shila-drupal/scripts/bootstrap-data.sh"
