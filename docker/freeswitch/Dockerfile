FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

WORKDIR /freeswitch

RUN apt update && apt install -y \
    wget curl gnupg lsb-release \
    systemd systemd-sysv sudo \
    iproute2 net-tools vim \
    && apt clean

COPY ./resources /freeswitch/resources

COPY ./install.sh /freeswitch/install.sh

# Install FreeSWITCH
RUN chmod +x /freeswitch/install.sh && \
    cd /freeswitch && ./install.sh

# SIP ports
EXPOSE 5060/udp 5060/tcp
EXPOSE 5061/udp 5061/tcp

# RTP ports
EXPOSE 16384-32768/udp

CMD ["freeswitch", "-nonat", "-nf"]