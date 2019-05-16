#!/bin/bash

# remove cert/key if they exist already
[[ -f /sabnzbd/server.cert ]] && rm -f /sabnzbd/server.cert
[[ -f /sabnzbd/server.key ]] && rm -f /sabnzbd/server.key

# always ensure we have values for cert
Country=${Country:-US}
State=${State:-Reach}
Locality=${Locality:-Sector9}
Company=${Company:-MediaServices}
Department=${Department:-Mediaservices}
HostName=${HostName:-MediaBox.local}

openssl req -newkey rsa:4096 -nodes -keyout /sabnzbd/server.key \
-x509 -sha512 -days 3650 -out /sabnzbd/server.cert \
-subj "/C=${Country}/ST=${State}/L=${Locality}/O=${Company}/OU=${Department}/CN=${HostName}"
