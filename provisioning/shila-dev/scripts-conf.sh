#!/usr/bin/env bash

################################################################################
# Configurable variables, default values
################################################################################

# Instance, e.g. shila-dev or shila-prod.
INSTANCE=${INSTANCE:-shila-dev}

# Paths for the provisioning and instances directories. These can be mounted or
# symlinked paths to the actual directories.
PROVISIONING_ROOT=${PROVISIONING_ROOT:-/shila-provisioning}
INSTANCES_ROOT=${INSTANCES_ROOT:-/shila-instances}

# Timezone.
TIMEZONE=${TIMEZONE:-Europe/Helsinki}

# MySQL root password.
MYSQL_ROOT_PASSWORD=${MYSQL_ROOT_PASSWORD:-shila}

# The user account used to provision code and data.
# This must be an existing user account.
OWNER_USER=${OWNER_USER:-vagrant}


################################################################################
# Derived and fixed variables, do not change these
################################################################################

# Provisioning scripts directory.
SCRIPTS_DIR="${PROVISIONING_ROOT}/${INSTANCE}"

# Root directory for configuration files.
CONF_ROOT="${SCRIPTS_DIR}/conf"

# Instance directory.
INSTANCE_DIR="${INSTANCES_ROOT}/${INSTANCE}"

# Instance root directory. This is the base path used in configuration files.
# It will be created as a symbolic link to INSTANCE_DIR.
SHILA_ROOT="/var/www/${INSTANCE}"

# Code directory.
CODE_DIR="${SHILA_ROOT}/code"

# Data directory.
DATA_DIR="${SHILA_ROOT}/data"
