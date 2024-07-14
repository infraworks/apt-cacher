FROM docker.io/debian:12-slim

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update -y && \
    apt-get -qq install --no-install-recommends apt-cacher-ng \
    htop \
    apt-transport-https ca-certificates curl gpg \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
    && ln -s /dev/fd/1 /var/log/apt-cacher-ng/apt-cacher.log \
    && ln -s /dev/fd/1 /var/log/apt-cacher-ng/apt-cacher.err \
    && ln -s /dev/fd/1 /var/log/apt-cacher-ng/apt-cacher.dbg \
    && curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.30/deb/Release.key | gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg \
    && echo "AllowUserPorts: 80 443 3242" >> /etc/apt-cacher-ng/acng.conf \
    && sed -i 's/# PassThroughPattern: .* # this would allow CONNECT to everything/PassThroughPattern: .* # this would allow CONNECT to everything/g' /etc/apt-cacher-ng/acng.conf

CMD ["/bin/sh", "-c", "/usr/sbin/apt-cacher-ng -c /etc/apt-cacher-ng pidfile=/var/run/apt-cacher-ng/pid SocketPath=/var/run/apt-cacher-ng/socket foreground=1"]
