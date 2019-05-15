***

**WIP**

Status
======

- Installation of gzserver , running : OK
- direct rendering with glxinfo : OK
- installation of parrot-sphinx : OK
- running of firmwared : OK?
- running sphinx-server : FAIL


        make run
        root@sh15:/# firmwared 
        root@sh15:/# I firmwared_main: firmwared[497] starting
        E firmwared_main: initial_cleanup_files scandir: No such file or directory
        I firmwared_firmwares: indexing firmwares from folder '/usr/share/firmwared/firmwares/'
        I firmwared_firmwares: done indexing firmwares

        
        root@sh15:/# sphinx-server /opt/parrot-sphinx/usr/share/sphinx/worlds/outdoor_1.world /opt/parrot-sphinx/usr/share/sphinx/drones/bebop2.drone 
        [Msg] Waiting for master.
        [Msg] Connected to gazebo master @ http://127.0.0.1:11345
        [Msg] Publicized address: 127.0.0.1
        [Wrn] [ColladaLoader.cc:1763] Triangle input semantic: 'TEXCOORD' is currently not supported
        [Wrn] [ColladaLoader.cc:1763] Triangle input semantic: 'TEXCOORD' is currently not supported
        [Wrn] [ColladaLoader.cc:1763] Triangle input semantic: 'TEXCOORD' is currently not supported
        [Wrn] [ColladaLoader.cc:1763] Triangle input semantic: 'TEXCOORD' is currently not supported
        [Wrn] [ColladaLoader.cc:1763] Triangle input semantic: 'TEXCOORD' is currently not supported
        [Wrn] [ColladaLoader.cc:1763] Triangle input semantic: 'TEXCOORD' is currently not supported
        [Msg] created parameter server on http:8383
        [Msg] connected to firmwared
        [Msg] Preparation of firmware http://plf.parrot.com/sphinx/firmwares/ardrone3/milos_pc/latest/images/ardrone3-milos_pc.ext2.zip
        I shd: wind: created: generation=2 sample_count=4000 sample_size=24 sample_rate=1000 metadata_size=125
        W firmwared_log: ls: cannot access '/usr/share/firmwared/firmwares//*.firmware': No such file or directory
        W firmwared_log: stat: cannot stat '/usr/share/firmwared/firmwares//ardrone3-milos_pc.ext2.zip.a3223a5b-4bd8-9583-54ad-cb89d0a34087.firmware': No such file or directory
        [Msg] preparation of firmwares http://plf.parrot.com/sphinx/firmwares/ardrone3/milos_pc/latest/images/ardrone3-milos_pc.ext2.zip is at 18%
        [Msg] preparation of firmwares http://plf.parrot.com/sphinx/firmwares/ardrone3/milos_pc/latest/images/ardrone3-milos_pc.ext2.zip is at 82%
        [Msg] preparation of firmwares http://plf.parrot.com/sphinx/firmwares/ardrone3/milos_pc/latest/images/ardrone3-milos_pc.ext2.zip is at 100%
        [Msg] firmware /usr/share/firmwared/firmwares//ardrone3-milos_pc.ext2.zip.a3223a5b-4bd8-9583-54ad-cb89d0a34087.firmware supported hardwares: 
        [Msg]   milosboard
        I firmwared_instances: init_command_line: ro_boot_console = ro.boot.console=
        W firmwared_log: mount: wrong fs type, bad option, bad superblock on firmwared_967aac4b1a0fc3447e9a1073392d246347a46acc,
        W firmwared_log:        missing codepage or helper program, or other error
        W firmwared_log: 
        W firmwared_log:        In some cases useful info is found in syslog - try
        W firmwared_log:        dmesg | tail or so.
        E firmwared_instances: invoke_mount_helper init returned -125
        W firmwared_log: umount: /var/cache/firmwared/mount_points/instances/967aac4b1a0fc3447e9a1073392d246347a46acc/union: not mounted
        E firmwared_instances: invoke_mount_helper clean returned -125
        E firmwared_instances: install_mount_points
        I apparmor_config: apparmor_remove_profile(967aac4b1a0fc3447e9a1073392d246347a46acc)
        W firmwared_log: /sbin/apparmor_parser: Unable to remove "firmwared_967aac4b1a0fc3447e9a1073392d246347a46acc".  Profile doesn't exist
        E apparmor_config: /sbin/apparmor_parser exited with status 65024
        E firmwared_instances: rmdir '/var/run/firmwared/967aac4b1a0fc3447e9a1073392d246347a46acc/udev' error 2
        E firmwared_instances: rmdir '/var/run/firmwared/967aac4b1a0fc3447e9a1073392d246347a46acc' error 2
        E firmwared_instances: invoke_mount_helper clean_extra returned -125
        E firmwared_instances: invoke_mount_helper clean returned -125
        E firmwared_instances: init_instance: mount.hook/init failed.
        E firmwared_instances: instance_new(26b4c9adaa72df04d7821f9442cf04112232f549): Unknown error 1026
        E firmwared_commands: command_process: mount.hook/init failed.
        [Err] [Machine.cc:1256] Received error while preparing instance for machine bebop2: mount.hook/init failed.
        [Msg] CleanupInstances
        I firmwared_command_dropall: instances dropped 0/0
        [Msg] CleanupFirmwares
        [Msg] Firmware risible_bellatrix[26b4c9adaa72df04d7821f9442cf04112232f549] unprepared (unmounted)
        I shd: wind: closed


        
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
