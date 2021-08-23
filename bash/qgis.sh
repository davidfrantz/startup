#!/bin/bash

# LAUNCHER FOR DOCKERIZED QGIS
# ----------------------------------------------------------------------------------------
# (C) David Frantz 2021
# ----------------------------------------------------------------------------------------

# functions/definitions ------------------------------------------------------------------
export PROG=`basename $0`;
export BIN="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

export SCREEN_EXE="screen"
export DOCKER_EXE="docker"

echoerr() { echo "$PROG: $@" 1>&2; }    # warnings and/or errormessages go to STDERR
export -f echoerr

export DEBUG=false # display debug messages?
debug(){ if [ "$DEBUG" == "true" ]; then echo "DEBUG: $@"; fi } # debug message
export -f debug

cmd_not_found() {      # check required external commands
  for cmd in "$@"; do
    stat=`which $cmd`
    if [ $? != 0 ] ; then echoerr "\"$cmd\": external command not found, terminating..."; exit 1; fi
  done
}
export -f cmd_not_found

help () {
cat <<HELP

Usage: $PROG [-h] [-v]

  -h  = show his help
  -v  = QGIS version, e.g. release-3_18
        defaults to latest

HELP
exit 1
}
export -f help


# initial checks
cmd_not_found "$SCREEN_EXE $DOCKER_EXE"


# now get the options --------------------------------------------------------------------
ARGS=`getopt -o hv: --long help,version: -n "$0" -- "$@"`
if [ $? != 0 ] ; then help; fi
eval set -- "$ARGS"

# default options
VERSION=latest

while :; do
  case "$1" in
    -h|--help) help ;;
    -v|--version) VERSION="$2"; shift ;;
    -- ) shift; break ;;
    * ) break ;;
  esac
  shift
done

export VERSION
debug "version: $VERSION"


# some more checks
# anything to do?


# main thing -----------------------------------------------------------------------------

debug "user: $USER"
debug "home: $HOME"
debug "display: $DISPLAY"

# run in Docker in detached screen.
# screen will die when QGIS is closed
screen -S QGIS:$VERSION -d -m \
docker run \
  --rm \
  -e DISPLAY=${DISPLAY} \
  -e HOME=$HOME \
  --workdir=$HOME \
  -v /tmp/.X11-unix:/tmp/.X11-unix \
  -v $HOME:$HOME \
  -v /data:/data \
  -v /mnt:/mnt \
  --user=$(id -u $USER):$(id -g $USER) \
  --net host \
  qgis/qgis:$VERSION qgis

