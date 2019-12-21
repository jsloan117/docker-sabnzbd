# docker-sabnzbd

![License](https://img.shields.io/badge/License-GPLv3-blue.svg)
[![Build Status](https://travis-ci.com/jsloan117/docker-sabnzbd.svg?branch=master)](https://travis-ci.com/jsloan117/docker-sabnzbd)
[![Docker Pulls](https://img.shields.io/docker/pulls/jsloan117/sabnzbd.svg)](https://img.shields.io/docker/pulls/jsloan117/sabnzbd.svg)

SABnzbd on Alpine Linux

## Quick start

The below is a quick method to get this up and running. Please see the full documentation for more options.

``` bash
docker run -d --name sabnzbd \
-v /path/to/sabnzbd/downloaded:/data/completed \
-v /path/to/sabnzbd/downloading:/data/incomplete \
-v /path/to/sabnzbd:/config \
-e PUID=911 -e PGID=911 \
-p 8080:8080 \
jsloan117/sabnzbd
```

## Documentation

The full documentation is available [here](http://jsloan117.github.io/docker-sabnzbd).
