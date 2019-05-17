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

        
    DISPLAY=:99 make run
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

    [.....] 
    [Err] [Socket.cc:174] Socket 65 hung up
    pomp: recvmsg(fd=64) err=104(Connection reset by peer)
    31m[Err] [Socket.cc:174] Socket 65 hung up
    E pomp: recvmsg(fd=64) err=104(Connection reset by peer)


I still get issues... some on the parrot developer mentions it is linked to the nvidia driver not correctly installed but... glxinfo seems to output the right information and /usr/lib/nvidia-410 is correctly seens from the container... something else is missing ?

Then , from the host, I logged into the container again to ping the simulation and it seems to be running:

    fix_jer@host:/# docker ps
    CONTAINER ID        IMAGE                  COMMAND                  CREATED             STATUS              PORTS               NAMES
    7fb95bc54af5        nvidia-parrot-sphinx   "/run.sh /opt/parrot_"   6 minutes ago       Up 6 minutes                            friendly_poincare
    fix_jer@host:/# docker -it friendly_poincare /bin/bash
    
    root@sh15:/# gz stats 
    Factor[0.20] SimTime[118.91] RealTime[484.23] Paused[F]
    Factor[0.23] SimTime[118.98] RealTime[484.51] Paused[F]
    Factor[0.23] SimTime[119.04] RealTime[484.77] Paused[F]
    Factor[0.23] SimTime[119.10] RealTime[485.04] Paused[F]
    Factor[0.24] SimTime[119.18] RealTime[485.31] Paused[F]
    ^C

    root@sh15:/# gz topic --hz /gazebo/default/bebop2/body/horizontal_camera/image                                                        
    Hz:   3.90
    Hz:   3.66




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

To start sphinx server for anafi

    make run-anafi4k

To start sphinx server for bebop2

    make run-bebop2



Ressources
==========

- Parrot develop forum thread on running sphinx within a docker container : [Link](https://forum.developer.parrot.com/t/running-sphinx-inside-docker-container/9058/2
)
