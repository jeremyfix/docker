#!/bin/bash

if [ $# -lt 2  ]
then
    echo "Usage $0 path_to_world path_to_drone"
    exit 1
fi


set -m

mkdir -p /var/cache/firmwared
mount -ttmpfs tmpfs /var/cache/firmwared
mount -tsecurityfs securityfs /sys/kernel/security
mkdir -p /var/cache/firmwared/mount_points
firmwared &

echo "===> Starting sphinx_server"
#sphinx-server $1 $2 --port-forwarding=$3 #--log-level=dbg
sphinx-server $1 $2 #--log-level=dbg
