# Resilio Sync
#
# VERSION               0.1
#

FROM ubuntu
MAINTAINER Resilio Inc. <support@resilio.com>
LABEL com.resilio.version=""

ADD https://github.com/tianon/gosu/releases/download/1.8/gosu-amd64 /usr/local/bin/gosu
RUN chmod +x /usr/local/bin/gosu
RUN adduser -D sync

ADD https://download-cdn.resilio.com//linux-x64/resilio-sync_x64.tar.gz /tmp/sync.tgz
RUN tar -xf /tmp/sync.tgz -C /usr/bin rslsync && rm -f /tmp/sync.tgz

COPY sync.conf.default /etc/
COPY run_sync /usr/bin/

EXPOSE 8888
EXPOSE 55555

VOLUME /mnt/sync

ENTRYPOINT ["set -xe && gosu sync run_sync"]
CMD ["--config", "/mnt/sync/sync.conf"]
