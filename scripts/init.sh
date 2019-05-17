#!/bin/bash

# ensure supervisor directory & confs exist
if [[ ! -f /etc/supervisor.conf ]]; then
  if [[ ! -f /etc/supervisor/conf.d/sabnzbd.conf ]]; then
    mkdir -p /etc/supervisor/conf.d
    cp /configs/sabnzbd.conf /etc/supervisor/conf.d
  fi
  cp /configs/supervisor.conf /etc
fi

# set sabnzbd homedir
if [[ -n "${SABNZBD_HOME}" ]]; then
  sed -i "s|environment = SABNZBD_HOME=\(.*\)|environment = SABNZBD_HOME=${SABNZBD_HOME},|" /etc/supervisor/conf.d/sabnzbd.conf
fi
# set sabnzbd bind address
if [[ -n "${SABNZBD_BIND_ADDRESS}" ]]; then
  sed -i "s|SABNZBD_BIND_ADDRESS=\(.*\)|SABNZBD_BIND_ADDRESS=${SABNZBD_BIND_ADDRESS},|" /etc/supervisor/conf.d/sabnzbd.conf
fi
# set sabnzbd port
if [[ -n "${SABNZBD_PORT}" ]]; then
  sed -i "s|SABNZBD_PORT=\(.*\)|SABNZBD_PORT=${SABNZBD_PORT},|" /etc/supervisor/conf.d/sabnzbd.conf
fi
# set sabnzbd options
if [[ -n "${SABNZBD_OPTS}" ]]; then
  sed -i "s|SABNZBD_OPTS=\(.*\)|SABNZBD_OPTS=\'${SABNZBD_OPTS}\'|" /etc/supervisor/conf.d/sabnzbd.conf
fi

# ensure ownership & permissions are correctly set
/scripts/usersetup.sh

# start supervisord
exec /usr/bin/supervisord -c /etc/supervisor.conf -n
