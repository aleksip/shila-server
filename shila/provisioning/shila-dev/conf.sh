#!/usr/bin/env bash

if [ ! -z "$1" ]
  then
    INSTANCE="$1"
fi
if [ ! -z "$2" ]
  then
    CONF_ROOT="$2"
fi
if [ ! -z "$3" ]
  then
    source "$3"
  else
    MY_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
    source ${MY_DIR}/scripts.conf
fi
