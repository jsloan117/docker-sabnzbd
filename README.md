# docker-sabnzbd

Docker container for sabnzbd

![License](https://img.shields.io/badge/License-GPLv3-blue.svg)
![Docker Cloud Automated build](https://img.shields.io/docker/cloud/automated/jsloan117/sabnzbd.svg)
![Docker Build Status](https://img.shields.io/docker/cloud/build/jsloan117/sabnzbd.svg)
[![Docker Pulls](https://img.shields.io/docker/pulls/jsloan117/sabnzbd.svg)](https://img.shields.io/docker/pulls/jsloan117/sabnzbd.svg)
[![](https://images.microbadger.com/badges/image/jsloan117/sabnzbd.svg)](https://microbadger.com/images/jsloan117/sabnzbd "Get your own image badge on microbadger.com")

Docker container based on Alpine with SABnzbd

## Run container from Docker registry

The container is available from the Docker registry and this is the simplest way to get it.
To run the container use this command:

```bash
$ docker run -d --name sabnzbd \
-v /path/to/sabnzbd/downloaded:/data/completed \
-v /path/to/sabnzbd/downloading:/data/incomplete \
-v /path/to/sabnzbd:/config \
-v /etc/resolv.conf:/etc/resolv.conf:ro \
-v /etc/localtime:/etc/localtime:ro \
--env-file /dockerenvironmentfile/path/DockerEnv \
-p 8080:8080 \
jsloan117/sabnzbd
```

```bash
$ docker run -d --name sabnzbd \
-v /path/to/sabnzbd/downloaded:/data/completed \
-v /path/to/sabnzbd/downloading:/data/incomplete \
-v /path/to/sabnzbd:/config \
-v /etc/resolv.conf:/etc/resolv.conf:ro \
-v /etc/localtime:/etc/localtime:ro \
-e PUID=996 -e PGID=994 \
-e SAB_DOWNLOAD_DIR=/data/completed \
-e SAB_INCOMPLETE_DIR=/data/incomplete \
-e SAB_WATCH_DIR=/data/watched \
-p 8080:8080 \
jsloan117/sabnzbd
```

## Note

See DockerENV for complete list of environmental variables

### User configuration options

By default everything will run as the root user. However, it is possible to change who runs the sabnzbd process.
You may set the following parameters to customize the user id that runs sabnzbd.

| Variable | Function | Example |
|----------|----------|---------|
| `PUID` | Sets the user id who will run sabnzbd | `PUID=1000` |
| `PGID` | Sets the group id for the sabnzbd user | `PGID=1000` |

### SABnzbd environment options

| Variable  | Function | Example |
|-----------|----------|---------|
| `SABNZBD_HOME` | SABnzbd config files | `SABNZBD_HOME=/data/sabnzbd-home` |
| `SABNZBD_BIND_ADDRESS` | IP Address SABnzbd listens on | `SABNZBD_BIND_ADDRESS=0.0.0.0` |
| `SABNZBD_PORT` | Port SABnzbd listens on | `SABNZBD_PORT=8080` |
| `SABNZBD_OPTS` | SABnzbd startup options | `SABNZBD_OPTS='-b 0'` |

### create_cert.sh SSL options

This script can be manually ran to generate the certificate or automatically.

```bash
/scripts/create_cert.sh
```

| Variable  | Function                              | Defaults     |
|-----------|---------------------------------------|--------------|
| `GENCERT` | Generates SSL Cert with below options | unset |

| Variable     | Defaults                   |
|--------------|----------------------------|
| `Country`    | `Country=US`               |
| `State`      | `State=Reach`              |
| `Locality`   | `Locality=Sector9`         |
| `Company`    | `Company=MediaServices`    |
| `Department` | `Department=Mediaservices` |
| `HostName`   | `HostName=MediaBox.local`  |
