The container is available from the Docker registry and this is the simplest way to get it.
To run the container use one of the following commands:

``` bash
docker run -d --name sabnzbd \
-v /path/to/sabnzbd/downloaded:/data/completed \
-v /path/to/sabnzbd/downloading:/data/incomplete \
-v /path/to/sabnzbd:/config \
-v /etc/resolv.conf:/etc/resolv.conf:ro \
-v /etc/localtime:/etc/localtime:ro \
-e PUID=1000 -e PGID=1000 \
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