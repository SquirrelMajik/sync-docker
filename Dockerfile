# Resilio Sync
#
# VERSION               0.1
#

FROM ubuntu
MAINTAINER majik <me@yamajik.com>
LABEL com.resilio.version=""

RUN useradd btsync

RUN apt-get update
RUN apt-get install -y wget
RUN echo "deb http://linux-packages.resilio.com/resilio-sync/deb resilio-sync non-free" | tee /etc/apt/sources.list.d/
resilio-sync.list
RUN wget https://linux-packages.resilio.com/resilio-sync/key.asc
RUN apt-key add ./key.asc
RUN apt-get update
RUN apt-get install -y gosu resilio-sync

COPY sync.conf /etc/

RUN mkdir -p /mnt/sync/folders
RUN mkdir -p /mnt/sync/config

EXPOSE 8888
EXPOSE 55555

VOLUME /mnt/sync

# ENTRYPOINT ["set -xe && gosu btsync run_sync"]
CMD set -xe \
    && chown -R btsync:btsync /mnt/sync \
    && gosu btsync /usr/bin/rslsync --nodaemon --config /etc/sync.conf
