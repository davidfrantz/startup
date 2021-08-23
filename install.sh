#!/bin/bash

BIN="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

cd $BIN

mkdir -p $HOME/bin && \
cp bash/* $HOME/bin &&
cp .profile $HOME/.profile

exit 0
