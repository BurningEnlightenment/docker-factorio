#!/bin/bash
CSD="${BASH_SOURCE%/*}"
if [[ ! -d "${CSD}" ]]; then CSD="${PWD}"; fi

. "${CSD}/bash-lib/cprintf.sh"

hc_status "cleaning untagged images..."
docker rmi $(docker images --filter "dangling=true" -q --no-trunc)
