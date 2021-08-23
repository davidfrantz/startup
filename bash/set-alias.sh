#!/bin/bash

shopt -s expand_aliases

alias ff='cd $HOME/src/force'
alias search='find . -type f | xargs grep --binary-files=without-match'
alias memcheck='valgrind --tool=memcheck --leak-check=full'
alias jlab='jupyter lab --no-browser --port=8888'
alias jnote='jupyter notebook --no-browser --port=8888'

alias python=python3
alias pip=pip3
alias python-config=python3-config

alias dforce=' \
docker run \
-e FORCE_CREDENTIALS=/app/credentials \
-e BOTO_CONFIG=/app/credentials/.boto \
-v $HOME:/app/credentials \
-v /data:/data \
-v /mnt:/mnt \
-v $HOME:$HOME \
-w $PWD \
-u $(id -u):$(id -g) \
-t \
--rm \
davidfrantz/force'

alias dforce-dev=' \
docker run \
-e FORCE_CREDENTIALS=/app/credentials \
-e BOTO_CONFIG=/app/credentials/.boto \
-v $HOME:/app/credentials \
-v /data:/data \
-v /mnt:/mnt \
-v $HOME:$HOME \
-w $PWD \
-u $(id -u):$(id -g) \
-t \
--rm \
davidfrantz/force:dev'

alias dforce-dev-it=' \
docker run \
-e FORCE_CREDENTIALS=/app/credentials \
-e BOTO_CONFIG=/app/credentials/.boto \
-v $HOME:/app/credentials \
-v /data:/data \
-v /mnt:/mnt \
-v $HOME:$HOME \
-w $PWD \
-u $(id -u):$(id -g) \
-t \
-i \
--rm \
davidfrantz/force:dev \
bash'

alias dgdal=' \
docker run \
-v /data:/data \
-v /mnt:/mnt \
-v $HOME:$HOME \
-w $PWD \
-u $(id -u):$(id -g) \
-t \
--rm \
osgeo/gdal'

#exit 0
