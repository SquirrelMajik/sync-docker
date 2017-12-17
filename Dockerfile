# Resilio Sync
#
# VERSION               0.1
#

FROM ubuntu
MAINTAINER majik <me@yamajik.com>
LABEL com.resilio.version="0.1"

RUN apt-get update
RUN apt-get install -y gosu
ADD https://download-cdn.resilio.com/2.5.9/linux-x64/resilio-sync_x64.tar.gz /tmp/sync.tgz
RUN tar -xf /tmp/sync.tgz -C /usr/bin rslsync && rm -f /tmp/sync.tgz

COPY sync.conf /etc/

RUN mkdir -p /mnt/sync/folders
RUN mkdir -p /mnt/sync/config
RUN useradd btsync

EXPOSE 8888
EXPOSE 55555

VOLUME /mnt/sync

CMD set -xe \
    && chown -R btsync:btsync /mnt/sync \
    && gosu btsync /usr/bin/rslsync --nodaemon --config /etc/sync.conf
