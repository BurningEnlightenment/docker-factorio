FROM debian:stable

ENV FACTORIO_VERSION=0.14.21 \
    FACTORIO_DIR="/opt/factorio" \
    FACTORIO_DATA_DIR="/var/factorio" \
    PACKAGE_HASH="9c2120c5ca15490ebe0fbbb13d23ce52cfa9d5643e329077da3ba0630876a42f"

COPY config/map-gen-settings.json config/server-settings.json $FACTORIO_DATA_DIR/settings/
COPY setup.sh bash-lib/cprintf.sh /var/
RUN /bin/bash /var/setup.sh && rm /var/setup.sh /var/cprintf.sh

WORKDIR $FACTORIO_DATA_DIR
EXPOSE 34197/udp
ENTRYPOINT ["/opt/factorio/bin/x64/factorio"]
CMD ["--start-server-load-latest","--server-settings","./settings/server-settings.json"]
