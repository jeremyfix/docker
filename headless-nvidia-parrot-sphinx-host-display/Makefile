
NVIDIA_PATH:=/usr/lib/nvidia-410
tmp_dir:=/tmp

build:
	docker build --network host --build-arg http_proxy=${http_proxy} --build-arg https_proxy=${https_proxy} --build-arg no_proxy=${no_proxy} -t nvidia-parrot-sphinx .

run:
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

		#-v /tmp/.X11-unix:/tmp/.X11-unix

glxinfo:
	docker run -it --rm --privileged --runtime=nvidia \
		--network host                                \
		-e DISPLAY=:99                                \
		-e NVIDIA_PATH=${NVIDIA_PATH}                 \
		-v ${NVIDIA_PATH}:${NVIDIA_PATH}:ro           \
		-v ${tmp_dir}:/tmp                            \
		-t nvidia-parrot-sphinx                       \
		glxinfo



