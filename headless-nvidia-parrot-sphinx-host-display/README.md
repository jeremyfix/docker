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
        [...]
        
        I firmwared_instances: init_command_line: ro_boot_console = ro.boot.console=
        I firmwared_instances: OUTER_PTS is /dev/pts/1
        I firmwared_instances: INNER_PTS is /dev/pts/2
        I apparmor_config: apparmor_load_profile(b6f267d639d45108d940785c5b22ade587b6f288)
        W firmwared_log: /usr/bin/env: 'python': No such file or directory
        W firmwared_instances: invoke_post_prepare_instance_helper failed: -125
        [....]
        [Dbg] [MachineManager.cc:806] All machines have had their properties set
        [Msg] WEB DASHBOARD IS ACCESSIBLE at http://localhost:9002
        I firmwared_instances: launch_instance "/usr/share/firmwared/firmwares//anafi-pc.ext2.zip.34b8603f-cc3e-4bc2-8bbc-c4b1df6ef0ed.firmware"
        W firmwared_log: modprobe: ERROR: ../libkmod/libkmod.c:586 kmod_search_moddep() could not open moddep file '/lib/modules/4.4.0-140-generic/modules.dep.bin'
        W firmwared_log: modprobe: FATAL: Module ifb not found in directory /lib/modules/4.4.0-140-generic
        E firmwared_instances: invoke_net_helper config returned -125
        [Msg] Instance risible_stephanie[b6f267d639d45108d940785c5b22ade587b6f288] started
        [Msg] All drones instantiated
        W firmwared_log: Cannot find device "fd_veth0"
        [.....]
        [Dbg] [PompPool.cc:87] seqnum '4294967295' not found in pomp pool
        [Dbg] [Firmwared.cc:183] OnInstanceDead
        [Dbg] [PompPool.hh:173] PompRequest 4294967295 not found
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
