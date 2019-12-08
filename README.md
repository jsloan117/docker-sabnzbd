# docker-sabnzbd

![License](https://img.shields.io/badge/License-GPLv3-blue.svg)
[![Build Status](https://travis-ci.org/jsloan117/docker-sabnzbd.svg?branch=master)](https://travis-ci.org/jsloan117/docker-sabnzbd)
[![Docker Pulls](https://img.shields.io/docker/pulls/jsloan117/sabnzbd.svg)](https://img.shields.io/docker/pulls/jsloan117/sabnzbd.svg)
[![](https://images.microbadger.com/badges/image/jsloan117/sabnzbd.svg)](https://microbadger.com/images/jsloan117/sabnzbd "Get your own image badge on microbadger.com")
[![HitCount](http://hits.dwyl.io/jsloan117/docker-sabnzbd.svg)](http://hits.dwyl.io/jsloan117/docker-sabnzbd)

This container is based on the tiny Alpine distro with SABnzbd.

## Quick start

``` bash
docker run -d --name sabnzbd \
-v /path/to/sabnzbd/downloaded:/data/completed \
-v /path/to/sabnzbd/downloading:/data/incomplete \
-v /path/to/sabnzbd:/config \
-e SAB_DOWNLOAD_DIR=/data/completed \
-e SAB_INCOMPLETE_DIR=/data/incomplete \
-e SAB_WATCH_DIR=/data/watched \
-p 8080:8080 \
jsloan117/sabnzbd
```

## Documentation

The full documentation is available [here](http://jsloan117.github.io/docker-sabnzbd).
