#!/bin/bash
set -e

CSD="${BASH_SOURCE%/*}"
if [[ ! -d "${CSD}" ]]; then CSD="${PWD}"; fi
. "${CSD}/cprintf.sh"

dc_status()
{
    printf "${CC_BLUE}===> ${CC_YELLOW}$1${CC_DEFAULT}\n"
}

dc_error()
{
    printf "${CC_MAGENTA}===> $1${CC_DEFAULT}\n"
}

SETUP_DEPS="curl"

# install curl for downloading the server binaries
dc_status "updating package databases..."
apt-get -y update
dc_status "installing curl..."
apt-get -y install ${SETUP_DEPS}

# download and verify the teamspeak server binaries
dc_status "downloading server binaries..."
curl https://www.factorio.com/get-download/${FACTORIO_VERSION}/headless/linux64 \
    -#Lo /tmp/factorio.tar.gz

dc_status "verifying checksum..."
echo "${PACKAGE_HASH} */tmp/factorio.tar.gz" \
    | sha256sum -c --status -

# extract binaries
dc_status "extracting server binaries..."
tar -xf /tmp/factorio.tar.gz --strip-components=1
rm /tmp/factorio.tar.gz

dc_status "initialize factorio (--create)"
./bin/x64/factorio --create map --map-gen-settings ./settings/map-gen-settings.json --server-settings ./settings/server-settings.json
mkdir saves

rm -rf temp map.zip
pushd data
rm *.example.json
popd

# cleanup
dc_status "uninstalling curl & friends..."
apt-get -y purge $SETUP_DEPS `apt-mark showauto`
apt-get clean
