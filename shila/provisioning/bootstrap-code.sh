#!/usr/bin/env bash

mkdir -p /var/www/shila-dev/code

# Shila Drupal
cd /var/www/shila-dev/code
(cd shila-drupal && git pull) || git clone https://github.com/aleksip/shila-drupal
/var/www/shila-dev/code/shila-drupal/scripts/bootstrap-code.sh

# Pattern Lab
cd /var/www/shila-dev/code
(cd patternlab-php && git pull) || git clone https://github.com/pattern-lab/patternlab-php
rm -rf /var/www/shila-dev/code/patternlab-php/source
ln -fs /var/www/shila-dev/code/shila-drupal/d8/web/sites/shila.dev/themes/shila_theme /var/www/shila-dev/code/patternlab-php/source
cd /var/www/shila-dev/code/patternlab-php
php core/builder.php -g
