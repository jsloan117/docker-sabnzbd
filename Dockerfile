FROM alpine:latest
LABEL Name=sabnzbd Version=1.1
LABEL maintainer="Jonathan Sloan"

ENV SABVER=2.3.9 PAR2=0.8.0

RUN apk add --no-cache ca-certificates py2-six py2-cryptography py-enum34 \
                       py2-cffi py2-cheetah py2-openssl openssl unzip unrar p7zip python2 \
                       py2-pip build-base libgomp automake autoconf python2-dev \
                       bash tini shadow supervisor \
    && wget -O- https://github.com/sabnzbd/sabnzbd/releases/download/$SABVER/SABnzbd-$SABVER-src.tar.gz | tar -zx \
    && mv SABnzbd-*/ /sabnzbd \
    && wget -O- https://github.com/Parchive/par2cmdline/releases/download/v$PAR2/par2cmdline-$PAR2.tar.gz | tar -zx \
    && cd par2cmdline-$PAR2 \
    && aclocal \
    && automake --add-missing \
    && autoconf \
    && ./configure \
    && make \
    && make install \
    && cd .. \
    && rm -rf par2cmdline-$PAR2 \
    && pip --no-cache-dir install --upgrade sabyenc \
    && echo "*** cleanup ***" \
    && rm -rf /tmp/* /var/tmp/* /var/cache/apk/* \
    && apk del build-base automake autoconf python2-dev \
    && useradd -u 911 -U -d /sabnzbd -s /bin/false abc

ADD configs /configs
ADD scripts /scripts

ENV SABNZBD_HOME=/config \
    SABNZBD_BIND_ADDRESS=0.0.0.0 \
    SABNZBD_PORT=8080 \
    SABNZBD_HTTPS_PORT= \
    SABNZBD_OPTS='-l 0 -b 0' \
    SAB_DOWNLOAD_DIR=/data/completed \
    SAB_INCOMPLETE_DIR=/data/incomplete \
    SAB_WATCH_DIR=/data/watched \
    SAB_NZB_BACKUP= \
    PUID= \
    PGID= \
    UMASK= \
    SSL= \
    GENCERT= \
    Country=US \
    State=Reach \
    Locality=Sector9 \
    Company=MediaServices \
    Department=Mediaservices \
    HostName=MediaBox.local

VOLUME /config /data
EXPOSE 8080
ENTRYPOINT [ "/sbin/tini", "--" ]
CMD [ "/bin/bash", "/scripts/init.sh" ]
