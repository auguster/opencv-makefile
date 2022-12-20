#!/bin/bash
# Uses a docker container to build OpenCV
# This is usefull if you want to use OpenCV in another docker container with CUDA

docker rm build-opencv
docker run -it --name build-opencv -v $PWD/opencv:/var/build/opencv -v $PWD/opencv_contrib:/var/build/opencv_contrib -v $PWD/makefile:/var/build/makefile nvidia/cuda:11.8.0-cudnn8-devel-ubuntu18.04 /bin/bash -c "cd /var/build; \
	apt-get update; \
	DEBIAN_FRONTEND=noninteractive make dep; \
	make clean; \
	make options='-DWITH_CUDA=ON -DOPENCV_ENABLE_NONFREE=ON' opencv/release/Makefile; \
	make opencv.deb
"

docker cp build-opencv:/var/build/opencv.deb ./opencv.deb