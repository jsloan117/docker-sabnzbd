#!/bin/bash

# if config file doesnt exist (wont exist until started 1st time) then copy default config file
if [[ ! -f ${SABNZBD_HOME}/sabnzbd.ini ]]; then
  echo "[INFO] Deluge config file doesn't exist, copying default..."
  cp /configs/sabnzbd.ini ${SABNZBD_HOME}
else
  echo "[INFO] Deluge config file already exists, skipping copy"
fi

# generate self-signed SSL cert
if [[ -n "${GENCERT}" ]] && [[ "${GENCERT}" = 'yes' ]]; then
  /scripts/create_cert.sh
fi

# set sabnzbd SSL setting
if [[ -n "${SSL}" ]] && [[ "${SSL}" = 'yes' ]]; then
  sed -i "s|enable_https = \(.*\)|enable_https = 1|" ${SABNZBD_HOME}/sabnzbd.ini
  sed -i "s|enable_https_verification = \(.*\)|enable_https_verification = 0|" ${SABNZBD_HOME}/sabnzbd.ini
elif [[ -n "${SSL}" ]] && [[ "${SSL}" = 'no' ]]; then
  sed -i "s|enable_https = \(.*\)|enable_https = 0|" ${SABNZBD_HOME}/sabnzbd.ini
fi

# set sabnzbd completed directory
if [[ -n "${SAB_DOWNLOAD_DIR}" ]]; then
  sed -i "s|complete_dir = \(.*\)|complete_dir = $SAB_DOWNLOAD_DIR|" ${SABNZBD_HOME}/sabnzbd.ini
fi

# set sabnzbd incomplete directory
if [[ -n "${SAB_INCOMPLETE_DIR}" ]]; then
  sed -i "s|download_dir = \(.*\)|download_dir = $SAB_INCOMPLETE_DIR|" ${SABNZBD_HOME}/sabnzbd.ini
fi

# set sabnzbd watch directory
if [[ -n "${SAB_WATCH_DIR}" ]]; then
  sed -i "s|dirscan_dir = \(.*\)|dirscan_dir = $SAB_WATCH_DIR|" ${SABNZBD_HOME}/sabnzbd.ini
fi

# set sabnzbd torrent backup directory
if [[ -n "${SAB_NZB_BACKUP}" ]]; then
  sed -i "s|nzb_backup_dir = \(.*\)|nzb_backup_dir = $SAB_NZB_BACKUP|" ${SABNZBD_HOME}/sabnzbd.ini
fi

echo "[INFO] Starting SABnzbd..."
# run sabnzbd daemon
/usr/bin/python -OO /sabnzbd/SABnzbd.py -f ${SABNZBD_HOME} -s ${SABNZBD_BIND_ADDRESS}:${SABNZBD_PORT} ${SABNZBD_OPTS}
echo "[INFO] SABnzbd process started"

echo "[INFO] Waiting for SABnzbd process to start listening on port ${SABNZBD_PORT}..."
while [[ $(netstat -lnt | awk "\$6 == \"LISTEN\" && \$4 ~ \".\${SABNZBD_PORT}\"") ]]; do
  sleep 0.1
done

echo "[INFO] SABnzbd process listening on port ${SABNZBD_PORT}"
