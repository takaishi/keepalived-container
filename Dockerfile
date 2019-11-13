FROM alpine
MAINTAINER Ryo TAKAISHI <ryo.takaishi.0@gmail.com>

ENV VERSION 2.0.16

RUN apk update && apk add \
  iptables-dev ipset-dev libnl3-dev musl-dev libnftnl-dev openssl-dev  \
  curl tar automake autoconf gcc net-snmp-dev make

WORKDIR /tmp

RUN curl -sSL "https://github.com/acassen/keepalived/archive/v$VERSION.tar.gz" -o keepalived-v$VERSION.tar.gz
RUN tar xzf keepalived-v$VERSION.tar.gz

WORKDIR /tmp/keepalived-$VERSION

RUN aclocal && \
  autoheader && \
  automake --add-missing && \
 autoreconf

RUN ./configure \
  --sysconfdir=/etc \
  --enable-snmp

RUN make && make install
