#!/bin/bash

set -e

RUN_AS=root

if [ -n "${PUID}" ] && [ ! "$(id -u root)" -eq "${PUID}" ]; then
  RUN_AS=abc
  if [ ! "$(id -u ${RUN_AS})" -eq "${PUID}" ]; then usermod -o -u "${PUID}" ${RUN_AS} ; fi
  if [ ! "$(id -g ${RUN_AS})" -eq "${PGID}" ]; then groupmod -o -g "${PGID}" ${RUN_AS} ; fi

  # Make sure directories exist before chown and chmod
  dlist=( "/data" "/sabnzbd" "${SABNZBD_HOME}" \
  "${SAB_DOWNLOAD_DIR}" "${SAB_INCOMPLETE_DIR}" \
  "${SAB_WATCH_DIR}" "${SAB_NZB_BACKUP}" )

  dirlist=()
  for xdir in "${dlist}"; do
    if [[ -n "${xdir}" ]]; then
      dirlist+=( "${xdir}" )
    fi
  done

  for xdir in "${dirlist[@]}"; do
    if [[ ! -d "${xdir}" ]]; then
      mkdir -p "${xdir}"
    fi
  done

  echo "[INFO] Setting owner for sabnzbd paths to ${PUID}:${PGID}"
  echo "[INFO] Setting permissions for files (644) and directories (755)"
  for xdir in "${dirlist[@]}"; do
    chown -R "${RUN_AS}":"${RUN_AS}" "${xdir}"
    chmod -R go=rX,u=rwX "${xdir}"
  done

  echo "[INFO] Setting permissions on SABnzbd.py to 755"
  chown -R "${RUN_AS}":"${RUN_AS}" /sabnzbd
  chmod 755 /sabnzbd/SABnzbd.py
fi

echo "
-------------------------------------
SABnzbd will run as
-------------------------------------
User name:   ${RUN_AS}
User uid:    $(id -u ${RUN_AS})
User gid:    $(id -g ${RUN_AS})
-------------------------------------
"

export PUID
export PGID
export RUN_AS
