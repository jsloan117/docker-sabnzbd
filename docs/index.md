<h1 align="center">
  docker-sabnzbd
</h1>

<p align="center">
  Docker container based on Alpine with SABnzbd
  <br/><br/>

  <a href="https://github.com/jsloan117/docker-sabnzbd/blob/master/LICENSE">
    <img alt="license" src="https://img.shields.io/badge/License-GPLv3-blue.svg" />
  </a>
  <a href="https://travis-ci.org/jsloan117/docker-sabnzbd">
    <img alt="build" src="https://travis-ci.org/jsloan117/docker-sabnzbd.svg?branch=master" />
  </a>
  <a href="https://hub.docker.com/repository/docker/jsloan117/sabnzbd">
    <img alt="pulls" src="https://img.shields.io/docker/pulls/jsloan117/sabnzbd.svg" />
  </a>
  <a href="https://microbadger.com/images/jsloan117/sabnzbd">
    <img alt="image" src="https://images.microbadger.com/badges/image/jsloan117/sabnzbd.svg" />
  </a>
  <a href="http://hits.dwyl.io/jsloan117/docker-sabnzbd">
    <img alt="hits" src="http://hits.dwyl.io/jsloan117/docker-sabnzbd.svg" />
  </a>
</p>

## Quick start

The below is a quick method to get this up and running. Please see the other documentation links for further details.

``` bash
docker run -d --name sabnzbd \
-v /path/to/sabnzbd/downloaded:/data/completed \
-v /path/to/sabnzbd/downloading:/data/incomplete \
-v /path/to/sabnzbd:/config \
-p 8080:8080 \
jsloan117/sabnzbd
```
