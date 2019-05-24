
NVIDIA_PATH:=/usr/lib/nvidia-410
IP:=192.168.10.79
tmp_dir:=/tmp

build:
	docker build --network host --build-arg http_proxy=${http_proxy} --build-arg https_proxy=${https_proxy} --build-arg no_proxy=${no_proxy} -t nvidia-parrot-sphinx .

bash:
	#sudo xhost +
	docker run -it --rm --privileged --runtime=nvidia \
		--env="DISPLAY" \
		--env="QT_X11_NO_MITSHM=1" \
		--volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" \
		--network host                                \
		-e NVIDIA_PATH=${NVIDIA_PATH}                 \
		-v ${NVIDIA_PATH}:${NVIDIA_PATH}:ro           \
		-v ${tmp_dir}:/tmp                            \
		-v /lib/modules:/lib/modules                  \
		-t nvidia-parrot-sphinx                       \
		/bin/bash

NVIDIA_DEVICE := $(shell ls /dev/nvidia* | xargs -I{} echo '--device={}') 
CUDA_LIBS := $(shell ls /usr/lib/x86_64-linux-gnu/libcuda* | xargs -I{} echo '-v {}:{}:ro')
NVIDIA_LIBS := $(shell ls /usr/lib/x86_64-linux-gnu/libnvidia* | xargs -I{} echo '-v {}:{}:ro')

test:
	@echo ${NVIDIA_DEVICE}
	@echo ${CUDA_LIBS}
	@echo ${NVIDIA_LIBS}

run-anafi4k:
	#sudo xhost +
	docker run -it --rm --privileged --runtime=nvidia \
		--env="DISPLAY" \
		--env="QT_X11_NO_MITSHM=1" \
		--volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" \
		--network host                                \
		-e NVIDIA_PATH=${NVIDIA_PATH}                 \
		-v ${NVIDIA_PATH}:${NVIDIA_PATH}:ro           \
		-v ${tmp_dir}:/tmp                            \
		-v /lib/modules:/lib/modules                  \
		${NVIDIA_DEVICE}  ${CUDA_LIBS} ${NVIDIA_LIBS}  \
		-t nvidia-parrot-sphinx                       \
		/run.sh /opt/parrot-sphinx/usr/share/sphinx/worlds/outdoor_1.world /opt/parrot-sphinx/usr/share/sphinx/drones/anafi4k.drone::stolen_interface=::simple_front_cam=0 

run-bebop2:
	#sudo xhost +
	docker run -it --rm --privileged --runtime=nvidia \
		--env="DISPLAY" \
		--env="QT_X11_NO_MITSHM=1" \
		--volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" \
		--network host                                \
		-e NVIDIA_PATH=${NVIDIA_PATH}                 \
		-v ${NVIDIA_PATH}:${NVIDIA_PATH}:ro           \
		-v ${tmp_dir}:/tmp                            \
		-v /lib/modules:/lib/modules                  \
		${NVIDIA_DEVICE}  ${CUDA_LIBS} ${NVIDIA_LIBS}  \
		-t nvidia-parrot-sphinx                       \
		/run.sh /opt/parrot-sphinx/usr/share/sphinx/worlds/outdoor_1.world /opt/parrot-sphinx/usr/share/sphinx/drones/bebop2.drone::stolen_interface=::with_front_cam=false 


glxinfo:
	docker run -it --rm --privileged --runtime=nvidia \
		--network host                                \
		-e DISPLAY=:99                                \
		-e NVIDIA_PATH=${NVIDIA_PATH}                 \
		-v ${NVIDIA_PATH}:${NVIDIA_PATH}:ro           \
		-v ${tmp_dir}:/tmp                            \
		-t nvidia-parrot-sphinx                       \
		glxinfo



