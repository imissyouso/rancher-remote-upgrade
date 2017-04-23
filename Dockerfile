FROM ubuntu:16.04

RUN apt-get update \
    && apt-get install -y zip unzip wget curl \
    && apt-get clean

# Rancher
ENV VERSION_NUM="0.12.4"
ENV RANCHER_URL="test"
ENV RANCHER_ACCESS_KEY="test"
ENV RANCHER_SECRET_KEY="test"
ENV RANCHER_STACK_ID="1st12"
ENV RANCHER_STACK_NAME="riki-cn"

RUN wget https://github.com/rancher/rancher-compose/releases/download/v${VERSION_NUM}/rancher-compose-linux-amd64-v${VERSION_NUM}.tar.gz && \
    tar zxf rancher-compose-linux-amd64-v${VERSION_NUM}.tar.gz && \
    rm rancher-compose-linux-amd64-v${VERSION_NUM}.tar.gz && \
    mv rancher-compose-v${VERSION_NUM}/rancher-compose /usr/local/bin/rancher-compose && \
    chmod +x /usr/local/bin/rancher-compose && \
    rm -r rancher-compose-v${VERSION_NUM}

ADD rancher-upgrade.sh /opt/rancher-upgrade.sh
RUN chmod +x /opt/rancher-upgrade.sh

ENTRYPOINT ["/opt/rancher-upgrade.sh"]