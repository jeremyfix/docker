
build:
	docker build --network host --build-arg http_proxy=${http_proxy} --build-arg https_proxy=${https_proxy} --build-arg no_proxy=${no_proxy} -t nvidia-gzserver7 .

run:
	docker run -it -e DISPLAY=:99 -v /tmp/.X11-unix:/tmp/.X11-unix --privileged --runtime=nvidia  --rm --network host -t nvidia-gzserver7

glxinfo:
	docker run -it -e DISPLAY=:99 -v /tmp/.X11-unix:/tmp/.X11-unix --privileged --runtime=nvidia  --rm --network host -t nvidia-gzserver7 glxinfo  
