FROM debian:stable

ENV FACTORIO_VERSION=0.14.22 \
    FACTORIO_DIR="/opt/factorio" \
    PACKAGE_HASH="c46c499e0ec89b0c406abe01f121526efb9baad1b068692d85b8ceca0e6a8777"
WORKDIR $FACTORIO_DIR

COPY config/map-gen-settings.json config/server-settings.json ./settings/
COPY setup.sh bash-lib/cprintf.sh /var/
RUN /bin/bash /var/setup.sh && rm /var/setup.sh /var/cprintf.sh

EXPOSE 34197/udp
ENTRYPOINT ["./bin/x64/factorio"]
CMD ["--start-server-load-latest","--server-settings","./settings/server-settings.json","--mod-directory","./mods"]
