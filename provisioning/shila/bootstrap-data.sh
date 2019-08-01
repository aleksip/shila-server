#!/usr/bin/env bash

# shellcheck source=scripts-conf.sh
source "$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )/scripts-conf.sh"

# Shila Drupal
"${CODE_DIR}/shila-drupal/scripts/bootstrap-data.sh"
