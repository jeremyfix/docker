
This dockerfile runs gzserver on a headless server. It uses a dummy Xserver running on the host. The docker container then uses the display of the hosrt


Setup of the host
=================

    apt-get install -y xserver-xorg-video-dummy
    nvidia-xconfig -a --allow-empty-initial-configuration  --use-display-device=none  --virtual=1920x1200
    Xorg -noreset +extension GLX +extension RANDR +extension RENDER +iglx -logfile /tmp/xdummy.log -config /etc/X11/xorg.conf :99

You may get non fatal errors from xkbcomp. These are non fatal on headless servers since they do not have a keyboard attached I suppose.

If Xorg is not executed as root (or some config to set ? or using xpra?), you may get :

    Fatal server error:
    (EE) parse_vt_settings: Cannot open /dev/tty0 (Permission denied)


And then you can test glxinfo within your host

    shell:$ DISPLAY=:99 glxinfo | grep ^direct
    direct rendering: Yes



Running
=======

To build the image

    make build

To test glxinfo within the docker container :

    make glxinfo | grep ^direct
    # Should output
    direct rendering: Yes

To start gzserver

    make run

    # Should output something like
    ===> Starting gzserver
    Gazebo multi-robot simulator, version 7.15.0
    Copyright (C) 2012 Open Source Robotics Foundation.
    Released under the Apache 2 License.
    http://gazebosim.org

    [Msg] Waiting for master.
    [Msg] Connected to gazebo master @ http://127.0.0.1:11345
    [Msg] Publicized address: 192.168.10.79===> Starting gzserver

Ressources
==========

- Parrot develop forum thread on running sphinx within a docker container : [Link](https://forum.developer.parrot.com/t/running-sphinx-inside-docker-container/9058/2)
