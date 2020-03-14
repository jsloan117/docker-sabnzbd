FROM alpine:3.11
LABEL Name=sabnzbd Maintainer="Jonathan Sloan"

ARG SABVER=2.3.9
ARG PAR2=0.8.1

SHELL ["/bin/ash", "-eo", "pipefail", "-c"]

RUN apk add --no-cache ca-certificates openssl unzip unrar p7zip python2 \
                       py2-pip build-base libgomp automake autoconf python2-dev \
                       bash tini shadow supervisor \
    && pip --no-cache-dir install six cryptography enum34 cffi Cheetah3 pyOpenSSL \
    && wget -O- "https://github.com/sabnzbd/sabnzbd/releases/download/${SABVER}/SABnzbd-${SABVER}-src.tar.gz" | tar -zx \
    && mv "SABnzbd-${SABVER}/" /sabnzbd \
    && wget -O- "https://github.com/Parchive/par2cmdline/releases/download/v${PAR2}/par2cmdline-${PAR2}.tar.gz" | tar -zx \
    && cd "par2cmdline-${PAR2}" \
    && aclocal \
    && automake --add-missing \
    && autoconf \
    && ./configure \
    && make -j2 \
    && make install \
    && cd .. \
    && rm -rf "par2cmdline-${PAR2}" \
    && pip --no-cache-dir install --upgrade sabyenc \
    && echo "*** cleanup ***" \
    && apk del build-base automake autoconf python2-dev \
    && rm -rf /tmp/* /var/tmp/* /var/cache/apk/* /var/lib/apk/* "$HOME/.cache" \
    && useradd -u 911 -U -d /sabnzbd -s /bin/false abc

COPY configs /configs
COPY scripts /scripts
COPY VERSION .

ENV SABNZBD_HOME="/config" \
    SABNZBD_BIND_ADDRESS="0.0.0.0" \
    SABNZBD_PORT="8080" \
    SABNZBD_HTTPS_PORT="" \
    SABNZBD_OPTS="-l 0 -b 0" \
    SAB_DOWNLOAD_DIR="/data/completed" \
    SAB_INCOMPLETE_DIR="/data/incomplete" \
    SAB_WATCH_DIR="/data/watched" \
    SAB_NZB_BACKUP="" \
    PUID="" \
    PGID="" \
    UMASK="" \
    SSL="" \
    GENCERT="" \
    Country="US" \
    State="Reach" \
    Locality="Sector9" \
    Company="MediaServices" \
    Department="Mediaservices" \
    HostName="MediaBox.local"

VOLUME /config /data
EXPOSE 8080
ENTRYPOINT [ "/sbin/tini", "--" ]
CMD [ "/bin/bash", "/scripts/init.sh" ]
