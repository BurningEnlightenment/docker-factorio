#!/bin/bash
CSD="${BASH_SOURCE%/*}"
if [[ ! -d "${CSD}" ]]; then CSD="${PWD}"; fi

. "${CSD}/bash-lib/cprintf.sh"
. "${CSD}/details/info.sh"

if [ -f "${CID_FILE}" ]
then
    hc_status "found a container id, removing old container...\n"
    CONTAINER_ID=$(<"${CID_FILE}")
    rm "${CID_FILE}"
    docker stop ${CONTAINER_ID} > /dev/null
    msg_on_failure $? "failed to stop old container\n"
    docker rm ${CONTAINER_ID} > /dev/null
    msg_on_failure $? "failed to remove old container\n"
fi

if [ ! -d "${CID_DIR}" ]
then
    hc_status "creating cid directory ${CID_DIR}...\n"
    mkdir -p ${CID_DIR}
    exit_on_failure $?
fi

hc_status "running ${IMAGE}:latest...\n"
docker run  --cidfile="${CID_FILE}" \
            --name="${CONTAINER}" \
            -d -p=34197:34197/udp \
            --volume=factorio-map:/opt/factorio/saves:z \
            --restart=unless-stopped ${IMAGE}:latest

exit_with_msg $?
