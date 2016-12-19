#!/bin/bash
CSD="${BASH_SOURCE%/*}"
if [[ ! -d "${CSD}" ]]; then CSD="${PWD}"; fi

. "${CSD}/bash-lib/cprintf.sh"
. "${CSD}/details/info.sh"

extract_factorio_version "${CSD}/Dockerfile"
curl -L https://www.factorio.com/get-download/${FACTORIO_VERSION}/headless/linux64 \
    | sha256sum -b -
