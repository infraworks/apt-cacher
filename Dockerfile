FROM docker.io/debian:12-slim

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update -y && \ 
    apt-get install -y --no-install-recommends apt-cacher-ng \
    htop \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
    && ln -s /dev/fd/1 /var/log/apt-cacher-ng/apt-cacher.log \
    && ln -s /dev/fd/1 /var/log/apt-cacher-ng/apt-cacher.err \ 
    && ln -s /dev/fd/1 /var/log/apt-cacher-ng/apt-cacher.dbg

CMD ["/bin/sh", "-c", "/usr/sbin/apt-cacher-ng -c /etc/apt-cacher-ng pidfile=/var/run/apt-cacher-ng/pid SocketPath=/var/run/apt-cacher-ng/socket foreground=1"]
