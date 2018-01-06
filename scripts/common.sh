#!/bin/bash
TERM=xterm-256color

sred=$(tput setaf 1)
swhite=$(tput setaf 7)
sbold=$(tput bold)
snormal=$(tput sgr0)

function bold {
  echo "${sbold}$*${snormal}"
}

function red {
  echo "${sbold}${sred}$*${snormal}"
}

function white {
  echo "${swhite}$*${snormal}"
}

function export_variable {
  ARG_NAME=$1
  ARG_VALUE=$2
  eval "export $ARG_NAME=$ARG_VALUE"
}

function enforce_arg {
  ARG_NAME="$1"
  ARG_DESC="$2"
  ARG_VALUE="${!1}"
  ARG_DEFAULT="$3"

  if [ -z "$ARG_VALUE" ]; then
    if [ ! -z "$ARG_DEFAULT" ]; then
      export_variable "$ARG_NAME" "$ARG_DEFAULT"
      white " + $ARG_NAME"
      echo "   = $ARG_DEFAULT (default value)"
    else
      red " - $ARG_NAME"
      echo "   $ARG_DESC"
      MISSING_VAR="1"
    fi
  else
    export_variable "$ARG_NAME" "$ARG_VALUE"
    white " + $ARG_NAME"
    echo "   = $ARG_VALUE"
    return;
  fi
}
