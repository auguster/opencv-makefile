all: install

dep:
	sudo apt-get install cmake git build-essential libdc1394-22-dev libv4l-dev libavcodec-dev libavutil-dev libavformat-dev libavutil-dev libswscale-dev libx264-dev libeigen3-dev libgtk2.0-dev libgstreamer1.0-dev libgstreamer-vaapi1.0-dev libtbb-dev gstreamer-base-1.0 gstreamer-video-1.0 gstreamer-app-1.0 gstreamer-riff-1.0 gstreamer-pbutils-1.0 
	
dep-graphic: dep
	sudo apt-get install libqt4-dev libqt4-opengl-dev

opencv_contrib:
	git clone https://github.com/itseez/opencv_contrib.git

opencv:
	git clone https://github.com/itseez/opencv.git

opencv/release: | opencv
	mkdir opencv/release

opencv/release/Makefile: | opencv/release opencv_contrib
	cd opencv/release/; cmake -D CMAKE_BUILD_TYPE=RELEASE -DOPENCV_EXTRA_MODULES_PATH=../../opencv_contrib/modules ..

opencv/release/lib/libopencv_core.so: build

build: opencv/release/Makefile
	make -C opencv/release -j $$(( $$(nproc) - 1 )) -l $$(nproc)

install: opencv/release/lib/libopencv_core.so
	sudo make -C opencv/release install
	sudo ldconfig

clean:
	rm -rf opencv/release

mrproper:
	rm -rf opencv/ opencv_contrib/ 

.PHONY: dep-server dep-graphic clean mrproper 
