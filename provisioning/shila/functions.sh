#!/usr/bin/env bash

# Check out or update repositories.
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
