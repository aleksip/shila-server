#!/usr/bin/env bash

# shellcheck source=scripts-conf.sh
source "$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )/scripts-conf.sh"

sudo phpenmod xdebug
sudo "${SCRIPTS_DIR}/start-services.sh"
