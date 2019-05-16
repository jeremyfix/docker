#!/bin/bash

set -m

mkdir -p /var/cache/firmwared
mount -ttmpfs tmpfs /var/cache/firmwared
mount -tsecurityfs securityfs /sys/kernel/security
mkdir -p /var/cache/firmwared/mount_points
firmwared &
# gzserver
echo "===> Starting gzserver"
sphinx /opt/parrot-sphinx/usr/share/sphinx/worlds/outdoor_1.world /opt/parrot-sphinx/usr/share/sphinx/drones/anafi4k.drone::stolen_interface= --log-level=dbg
