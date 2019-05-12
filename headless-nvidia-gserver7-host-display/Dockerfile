FROM nvidia/opengl:1.0-glvnd-runtime-ubuntu16.04

ENV http_proxy ${http_proxy}
ENV https_proxy ${https_proxy}
ENV no_proxy ${no_proxy}

RUN apt-get update -q && DEBIAN_FRONTEND=noninteractive apt-get install -y \
    wget                       \
    software-properties-common \ 
    lsb-release                \ 
    mesa-utils                 \
	debconf-utils


################################
#   Gazebo
################################


# install packages
RUN apt-get update -q && DEBIAN_FRONTEND=noninteractive apt-get install -q -y \
        dirmngr           \
        gnupg2            

# setup keys
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys D2486D2DD83DB69272AFE98867170598AF249743

# setup sources.list
RUN . /etc/os-release \
    && echo "deb http://packages.osrfoundation.org/gazebo/$ID-stable `lsb_release -sc` main" > /etc/apt/sources.list.d/gazebo-latest.list

# install gazebo packages
RUN apt-get update -q && DEBIAN_FRONTEND=noninteractive apt-get install -q -y \
    gazebo7=7.15.0-1* 

RUN bash /usr/share/gazebo/setup.sh

# setup environment
EXPOSE 11345


ADD run.sh /run.sh
RUN chmod a+x /run.sh
CMD /run.sh
