There are many variables and options available to customize how SABnzbd is ran.

## User configuration options

You may set the following parameters to customize the user id that runs sabnzbd.

| Variable | Function                               | Example     |
| -------- | -------------------------------------- | ----------- |
| `PUID`   | Sets the user id who will run sabnzbd  | `PUID=911`  |
| `PGID`   | Sets the group id for the sabnzbd user | `PGID=911`  |
| `UMASK`  | Set file mode mask                     | `UMASK=002` |

## SABnzbd environment options

The below are example settings, while some may actually be the defaults, some variables are unset.

| Variable               | Function                      | Example                               |
| ---------------------- | ----------------------------- | ------------------------------------- |
| `SABNZBD_HOME`         | SABnzbd config files          | `SABNZBD_HOME=/data/sabnzbd-home`     |
| `SABNZBD_BIND_ADDRESS` | IP Address SABnzbd listens on | `SABNZBD_BIND_ADDRESS=0.0.0.0`        |
| `SABNZBD_PORT`         | Port SABnzbd listens on       | `SABNZBD_PORT=8080`                   |
| `SABNZBD_HTTPS_PORT`   | Secure port                   | `SABNZBD_HTTPS_PORT=8081`             |
| `SABNZBD_OPTS`         | Startup options               | `SABNZBD_OPTS='-l 0 -b 0'`            |
| `SAB_DOWNLOAD_DIR`     | Completed downloads           | `SAB_DOWNLOAD_DIR=/data/completed`    |
| `SAB_INCOMPLETE_DIR`   | Incomplete downloads          | `SAB_INCOMPLETE_DIR=/data/incomplete` |
| `SAB_WATCH_DIR`        | Folder for importing nzbs     | `SAB_WATCH_DIR=/data/watched`         |
| `SAB_NZB_BACKUP`       | NZB file backups              | `SAB_NZB_BACKUP=/data/nzbbackups`     |

## SSL configuration options for create_cert.sh

This script can be manually ran to generate the certificate or automatically.

```bash
/scripts/create_cert.sh
```

| Variable  | Function                              | Defaults |
| --------- | ------------------------------------- | -------- |
| `SSL`     | Enables SSL within SABnzbd            | unset    |
| `GENCERT` | Generates SSL Cert with below options | unset    |

| Variable     | Defaults                   |
| ------------ | -------------------------- |
| `Country`    | `Country=US`               |
| `State`      | `State=Reach`              |
| `Locality`   | `Locality=Sector9`         |
| `Company`    | `Company=MediaServices`    |
| `Department` | `Department=Mediaservices` |
| `HostName`   | `HostName=MediaBox.local`  |
