#!/usr/bin/env bash

# shellcheck source=scripts-conf.sh
source "$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )/scripts-conf.sh"

source "${SCRIPTS_DIR}/functions.sh"

# Shila Drupal
shila_setup_repo "${CODE_DIR}" shila-drupal https://github.com/aleksip/shila-drupal
"${CODE_DIR}/shila-drupal/scripts/bootstrap-code.sh"
