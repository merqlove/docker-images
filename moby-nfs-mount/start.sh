#! /bin/sh

# get the shell envs
set -e

# check the the required vars are set
if [ -z "$SERVER" ]; then
    echo "SERVER var not set"
    exit 1
fi

if [ -z "$WSIZE" ]; then
  WSIZE="1048576"
fi

if [ -z "$RSIZE" ]; then
  RSIZE="1048576"
fi

if [ -z "$CACHE" ]; then
  CACHE="0"
fi

if [ -z "$MOUNT_OPTS" ]; then
  MOUNT_OPTS="hard"
fi

if [ -z "$TIMEO" ]; then
  TIMEO="600"
fi

if [ -z "$VERSION" ]; then
  VERSION="4"
fi

if [ -z "$RETRANS" ]; then
  RETRANS="2"
fi

FINAL_MOUNT_OPTS="nfsvers=$VERSION,rsize=$RSIZE,wsize=$WSIZE,$MOUNT_OPTS,timeo=$TIMEO,retrans=$RETRANS"

if [ -z "$MOUNTPOINT" ]; then
    echo "MOUNTPOINT var not set"
    exit 1
fi

# use nsenter to enter the docker host so we can mount the amazon EFS share in the host and all containers will have access to the mounted folder
# install required packages and mount the NFS share using env vars $SERVER and  $MOUNT
# create the $MOUNT dir if it doesn't exist
# and finally run inotifywait which will output all file folder and file operations so we have some basic logging
# apk add cachefilesd --update-cache --repository http://dl-3.alpinelinux.org/alpine/edge/community/ --allow-untrusted && \
# if test "$CACHE" = "1"; then /usr/bin/cachefilesd -f /etc/cachefilesd.conf -s; fi && \
nsenter -t 1 -m -u -i -n sh -c " \
    apk update && \
    apk add nfs-utils inotify-tools && \    
    mkdir -p $MOUNTPOINT && \
    mount -t nfs -o $FINAL_MOUNT_OPTS $SERVER $MOUNTPOINT && \
    inotifywait -m $MOUNTPOINT \
    "
