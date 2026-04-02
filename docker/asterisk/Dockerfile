FROM debian:12-slim

ENV DEBIAN_FRONTEND=noninteractive
ARG ASTERISK_VERSION=20

# 🧩 تثبيت المتطلبات
RUN apt-get update && apt-get install -y \
    build-essential git wget curl subversion \
    libxml2-dev libncurses5-dev uuid-dev libjansson-dev libssl-dev libsqlite3-dev \
    unixodbc unixodbc-dev mariadb-client libmariadb-dev libmariadb-dev-compat odbcinst \
    libusb-1.0-0-dev pkg-config autoconf automake libtool gettext-base ca-certificates \
    libedit-dev libcurl4-openssl-dev libspandsp-dev libnewt-dev \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /usr/src

# 🧱 بناء Asterisk
RUN wget -qO /tmp/asterisk.tar.gz https://downloads.asterisk.org/pub/telephony/asterisk/asterisk-${ASTERISK_VERSION}-current.tar.gz && \
    tar xzf /tmp/asterisk.tar.gz -C /usr/src && \
    cd /usr/src/asterisk-* && \
    bash contrib/scripts/get_mp3_source.sh && \
    ./configure && \
    make menuselect.makeopts && \
    menuselect/menuselect --enable-category MENUSELECT_ADDONS \
        --enable res_config_odbc \
        --enable func_odbc \
        --enable cdr_odbc \
        menuselect.makeopts && \
    make -j$(nproc) && \
    make install && \
    make samples && \
    make config && \
    ldconfig


# 🧩 نسخ ملفات headers الخاصة بـ Asterisk
RUN mkdir -p /usr/include/asterisk && \
    cp -r /usr/src/asterisk-*/include/* /usr/include/asterisk/

# 🔌 بناء chan_dongle
RUN cd /usr/src && \
    git clone https://github.com/wdoekes/asterisk-chan-dongle.git && \
    cd asterisk-chan-dongle && \
    ./bootstrap && \
    ./configure --with-asterisk=/usr/include/asterisk --with-astversion="${ASTERISK_VERSION}" && \
    make && \
    make install

RUN apt-get update && apt-get install -y \
    unixodbc unixodbc-dev odbcinst \
    mariadb-client odbc-mariadb libmariadb-dev \
    && rm -rf /var/lib/apt/lists/*

ENTRYPOINT envsubst < /etc/asterisk/res_odbc.conf > /etc/asterisk/res_odbc_runtime.conf && \
        mv /etc/asterisk/res_odbc_runtime.conf /etc/asterisk/res_odbc.conf && \
        /usr/sbin/asterisk -f -U root
USER root

CMD ["asterisk", "-f", "-vvv"]
