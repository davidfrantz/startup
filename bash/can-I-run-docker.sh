#!/bin/bash

echo ""
if getent group docker | grep -q "\b${USER}\b"; then
    echo "$USER is allowed to run Docker containers"
else
    echo -e '\033[7;31m'"$USER is not allowed to run Docker containers."'\033[0m'
    echo "Go and complain at your admin"
fi
echo ""

exit 0
