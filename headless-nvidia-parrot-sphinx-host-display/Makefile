
NVIDIA_PATH:=/usr/lib/nvidia-410
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
		-t nvidia-parrot-sphinx                       \
		/run.sh /opt/parrot-sphinx/usr/share/sphinx/worlds/outdoor_1.world /opt/parrot-sphinx/usr/share/sphinx/drones/anafi4k.drone::stolen_interface= 

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
		-t nvidia-parrot-sphinx                       \
		/run.sh /opt/parrot-sphinx/usr/share/sphinx/worlds/outdoor_1.world /opt/parrot-sphinx/usr/share/sphinx/drones/bebop2.drone::stolen_interface= 


glxinfo:
	docker run -it --rm --privileged --runtime=nvidia \
		--network host                                \
		-e DISPLAY=:99                                \
		-e NVIDIA_PATH=${NVIDIA_PATH}                 \
		-v ${NVIDIA_PATH}:${NVIDIA_PATH}:ro           \
		-v ${tmp_dir}:/tmp                            \
		-t nvidia-parrot-sphinx                       \
		glxinfo



