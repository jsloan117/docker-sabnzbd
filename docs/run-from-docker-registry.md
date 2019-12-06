The container is available from the Docker registry and this is the simplest way to get it.
To run the container use one of the following commands:

``` bash
docker run -d --name sabnzbd \
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

Using a docker environment file:

``` bash
docker run -d --name sabnzbd \
-v /path/to/sabnzbd/downloaded:/data/completed \
-v /path/to/sabnzbd/downloading:/data/incomplete \
-v /path/to/sabnzbd:/config \
-v /etc/resolv.conf:/etc/resolv.conf:ro \
-v /etc/localtime:/etc/localtime:ro \
--env-file DockerEnv \
-p 8080:8080 \
jsloan117/sabnzbd
```
