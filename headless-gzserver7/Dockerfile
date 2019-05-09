# For the definition of the xorg.conf files for a headless server, see : 
# http://cosmolinux.no-ip.org/raconetlinux2/dummy_radeon_nvidia.html 

FROM gazebo:gzserver7-xenial

ENV http_proxy ${http_proxy}
ENV https_proxy ${https_proxy}
ENV no_proxy ${no_proxy}

# DEBIAN_FRONTEND=noninteractive bypasses keyboard-configuration setup
# which is hanging ... do not know why . 
# If you need the keybaord configuration, you can copy/create a  /etc/default/keyboard file (man keyboard)
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y xserver-xorg-video-dummy
ADD xorg.conf /etc/X11/xorg.conf

RUN bash /usr/share/gazebo/setup.sh

# setup environment
EXPOSE 11345

# The dummy X11 server is running on display 99, see run.sh
ENV DISPLAY :99

ADD run.sh /run.sh
RUN chmod a+x /run.sh
CMD /run.sh
