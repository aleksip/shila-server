#!/usr/bin/env bash

MY_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
# shellcheck source=./scripts.conf
source "${MY_DIR}/scripts-conf.sh"

# Prepare directories.
mkdir -p "${CODE_DIR}"

# Shila Drupal
cd "${CODE_DIR}" || exit 1
if [ -d shila-drupal ]
  then
    cd shila-drupal || exit 1
    git pull
  else
    git clone -b "${SHILA_DRUPAL_BRANCH}" "${SHILA_DRUPAL_REPO}" shila-drupal
fi
"${CODE_DIR}/shila-drupal/scripts/bootstrap-code.sh"
