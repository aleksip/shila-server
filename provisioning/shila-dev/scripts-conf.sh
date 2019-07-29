#!/usr/bin/env bash

if [ -n "${SCRIPTS_CONF}" ]
  then
    # shellcheck source=./scripts.conf
    source "${SCRIPTS_CONF}"
  else
    # Instance, e.g. shila-dev or shila-prod.
    if [ -z "${INSTANCE}" ]
      then
        INSTANCE=shila-dev
    fi

    # You probably want to change these if you are not running the scripts in a
    # Vagrant guest.
    if [ -z "${CONF_ROOT}" ]
      then
        CONF_ROOT=/shila-provisioning/shila-dev/conf
    fi
    INSTANCES_ROOT=/shila-instances

    # Vagrant user.
    VAGRANT_USER=ubuntu

    # The user account used to provision code and data.
    # This must be an existing user account.
    OWNER_USER=ubuntu

    # Timezone.
    TIMEZONE=Europe/Helsinki

    # MySQL root password.
    # You might want to change this.
    MYSQL_ROOT_PASSWORD=shila

    # Shila root directory used by scripts and configuration.
    SHILA_ROOT=/var/www/${INSTANCE}

    # Other directories used by scripts and configuration.
    INSTANCE_DIR=${INSTANCES_ROOT}/${INSTANCE}
    CODE_DIR=${SHILA_ROOT}/code
    DATA_DIR=${SHILA_ROOT}/data
    SQL_DUMPS_DIR=${DATA_DIR}/sql-dumps

    # Repository and branch to clone Shila Drupal from.
    # You might want to change these based on the instance you are setting up.
    SHILA_DRUPAL_REPO=https://github.com/aleksip/shila-drupal
    SHILA_DRUPAL_BRANCH=master

    # Rsync options
    RSYNC_OPTIONS="-avz --iconv=utf-8-mac,utf-8 -e ssh"
    RSYNC_OPTIONS_DELETE="--delete ${RSYNC_OPTIONS}"
fi
