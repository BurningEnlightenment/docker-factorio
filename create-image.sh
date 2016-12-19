#!/bin/bash
CSD="${BASH_SOURCE%/*}"
if [[ ! -d "${CSD}" ]]; then CSD="${PWD}"; fi

. "${CSD}/bash-lib/cprintf.sh"
. "${CSD}/details/info.sh"

# extract version from Dockerfile
extract_factorio_version "${CSD}/Dockerfile"
set_tagged_image

hc_status "building ${TAGGED_IMAGE}..."
docker build --force-rm -t ${IMAGE}:latest -t "${TAGGED_IMAGE}" .

exit_with_msg $?
