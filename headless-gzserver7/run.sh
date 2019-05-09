#!/bin/bash

set -m

# X11 dummy server
echo "===> Running Xorg"
/usr/bin/Xorg -noreset +extension GLX +extension RANDR +extension RENDER -logfile ./xdummy.log -config /etc/X11/xorg.conf :99 &

# gzserver
echo "===> Starting gzserver"
gzserver --verbose
