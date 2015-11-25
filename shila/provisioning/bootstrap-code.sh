#!/usr/bin/env bash

# Shila Drupal
mkdir -p /var/www/shila-dev/code
cd /var/www/shila-dev/code
(cd shila-drupal && git pull) || git clone https://github.com/aleksip/shila-drupal
/var/www/shila-dev/code/shila-drupal/scripts/bootstrap-code.sh
