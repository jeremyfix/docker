***

**WIP**

Status
======

- Installation of gzserver , running : OK
- direct rendering with glxinfo : OK
- installation of parrot-sphinx : OK
- running of firmwared : Fail

        make run
        root@sh15:/# firmwared 
        [I] ut_module_init: the content of /proc/sys/kernel/modprobe doesn't point to valid executable 'modprobe', defaulting to /sbin/modprobe
        I firmwared_main: firmwared[12] starting
        E firmwared_main: initial_cleanup_files scandir: No such file or directory
        E apparmor_config: opening /sys/kernel/security/apparmor/profiles failed: No such file or directory
        I firmwared_firmwares: indexing firmwares from folder '/usr/share/firmwared/firmwares/'
        I firmwared_firmwares: done indexing firmwares
        E apparmor_config: AppArmor is not enabled or installed, please see the instructions for your distribution to enable it
        E firmwared_main: apparmor_init: Function not implemented
        E firmwared_main: init_subsystems: Function not implemented
        I firmwared_main: firmwared[12] exiting
        root@sh15:/# 



***

This dockerfile runs gzserver on a headless server. It uses a dummy Xserver running on the host. The docker container then uses the display of the hosrt


Setup
=====

    apt-get install -y xserver-xorg-video-dummy
    nvidia-xconfig -a --allow-empty-initial-configuration  --use-display-device=none  --virtual=1920x1200
    Xorg -noreset +extension GLX +extension RANDR +extension RENDER +iglx -logfile /tmp/xdummy.log -config /etc/X11/xorg.conf :99

You may get non fatal errors from xkbcomp. These are non fatal on headless servers since they do not have a keyboard attached I suppose.

If Xorg is not executed as root (or some config to set ? or using xpra?), you may get :

    Fatal server error:
    (EE) parse_vt_settings: Cannot open /dev/tty0 (Permission denied)


And then you can test glxinfo

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


Ressources
==========

- Parrot develop forum thread on running sphinx within a docker container : [Link](https://forum.developer.parrot.com/t/running-sphinx-inside-docker-container/9058/2
)