#!/bin/bash

IMAGE=burningenlightenment/factorioserver
CONTAINER=factorioserver

CID_DIR="${HOME}/.cids"
CID_FILE="${CID_DIR}/${CONTAINER}"

hc_status()
{
    printf "${CC_GREEN}==> ${CC_YELLOW}$1${CC_DEFAULT}\n"
}

hc_error()
{
    printf "${CC_RED}==> $1${CC_DEFAULT}\n"
}

extract_factorio_version()
{
    FACTORIO_VERSION=$(grep -Po "(?<=FACTORIO_VERSION=)\S+" "$1")
}

set_tagged_image()
{
    TAGGED_IMAGE="${IMAGE}:${FACTORIO_VERSION}"
}

msg_on_failure()
{
    if [ $1 -ne 0 ]
    then
        hc_error "$2"
    fi
}

exit_on_failure()
{
    local txt="$2 "
    if [ "$txt" = " " ]
    then
        local txt=""
    fi

    if [ $1 -ne 0 ]
    then
        hc_error "${txt}failed!\n"
        exit 1
    fi
}

exit_with_msg()
{
    local txt="$2 "
    if [ "$txt" = " " ]
    then
        local txt=""
    fi

    if [ $1 -ne 0 ]
    then
        hc_error "${txt}failed!\n"
        exit 1
    else
        hc_status "${txt}succeeded!\n"
        exit 0
    fi
}
