***

**WIP**

Status
======

- Installation of gzserver , running : OK
- direct rendering with glxinfo : OK
- installation of parrot-sphinx : OK
- running of firmwared : OK
- running sphinx-server : ok ? 

Only what seems to be interesting parts of the logs are displayed below.

        make run
        root@sh15:/# ./run.sh 
        [.. pretty long log....]
        [Msg] created parameter server on http:8383
        [Dbg] [Iio.cc:33] Creating IfIio object 'iio_simulator.sock'
        [Dbg] [MachineManager.cc:448] anafi4k: Machine(name = "anafi4k", firmware = "http://plf.parrot.com/sphinx/firmwares/anafi/pc/latest/images/anafi-pc.ext2.zip")
        property interface = eth1
        [Msg] connected to firmwared
        [....]
        [Dbg] [MachineManager.cc:806] All machines have had their properties set
        [Msg] WEB DASHBOARD IS ACCESSIBLE at http://localhost:9002

         
        
        
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
