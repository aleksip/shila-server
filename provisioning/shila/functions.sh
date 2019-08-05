#!/usr/bin/env bash

# Creates instance, code and data directories if they do not exist and sets
# correct owner/group.
shila_prepare_instance_dirs ()
{
  if [ ! -e "${INSTANCE_DIR}" ]; then mkdir -p "${INSTANCE_DIR}"; fi
  if [ ! -e "${SHILA_ROOT}" ]; then ln -sf "${INSTANCE_DIR}" "${SHILA_ROOT}"; fi
  if [ ! -e "${CODE_DIR}" ]
    then
      mkdir -p "${CODE_DIR}"
      test "${OWNER_USER}" != vagrant && ( chown "${OWNER_USER}":"${OWNER_USER}" "${CODE_DIR}" )
  fi
  if [ ! -e "${DATA_DIR}" ]
    then
      mkdir -p "${DATA_DIR}"
      test "${OWNER_USER}" != vagrant && ( chown "${OWNER_USER}":"${OWNER_USER}" "${DATA_DIR}" )
  fi
}

# Checks out or updates repositories.
#
# ${1} Base path
# ${2} Repository directory name
# ${3} Repository URL
# ${4} Branch (optional)
shila_setup_repo ()
{
  echo "Setting up repository ${2}..."
  cd "${1}" || exit 1
  if [ -d "${2}" ]
    then
      cd "${2}" || exit 1
      echo "Pulling possible updates..."
      git pull
    else
      if [ -z "${4}" ]
        then
          echo "Cloning default branch from ${3}..."
          git clone "${3}" "${2}"
        else
          echo "Cloning branch ${4} from ${3}..."
          git clone -b "${4}" "${3}" "${2}"
      fi
      cd "${2}" || exit 1
  fi
}
