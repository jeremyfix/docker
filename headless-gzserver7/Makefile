
build:
	docker build --network host --build-arg http_proxy=${http_proxy} --build-arg https_proxy=${https_proxy} --build-arg no_proxy=${no_proxy} -t mygazebo7 .

run:
	docker run -it  --rm --network host -t mygazebo7
