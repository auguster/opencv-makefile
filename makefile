OPENCV_VERSION=4.5.4

all: install

update: | opencv opencv_contrib
	cd opencv/ && git pull origin master
	cd opencv_contrib/ && git pull origin master

dep:
	apt-get install -q -y cmake git checkinstall build-essential libdc1394-*-dev libv4l-dev libavcodec-dev libavutil-dev libavformat-dev libavutil-dev libswscale-dev libx264-dev libeigen3-dev libgtk2.0-dev libgstreamer1.0-dev libgstreamer-plugins-base1.0-dev libtbb-dev libgtkglext1 libilmbase-dev libjbig-dev liblzma-dev libopenexr-dev libtiff5-dev libtiffxx5
	
dep-graphic: dep
	sudo apt-get install -y libqt5-dev libqt5opengl5-dev

opencv_contrib:
	git clone -b $(OPENCV_VERSION) --depth 1 https://github.com/opencv/opencv_contrib

opencv:
	git clone -b $(OPENCV_VERSION) --depth 1 https://github.com/opencv/opencv

opencv/release: | opencv
	mkdir opencv/release

opencv/release/Makefile: | opencv/release opencv_contrib
	make clean #necessary to make sure old configuration files are not present
	make opencv/release
	cd opencv/release/; cmake -D CMAKE_BUILD_TYPE=RELEASE -D OPENCV_GENERATE_PKGCONFIG=YES -DOPENCV_EXTRA_MODULES_PATH=../../opencv_contrib/modules $(options) ..

opencv/release/lib/libopencv_core.so: build

build: opencv/release/Makefile
	make -C opencv/release -j $$(( $$(nproc) - 2 )) -l $$(nproc)

opencv.deb: opencv/release/Makefile
	echo "OpenCV library compiled from git repository along with the contrib" > description-pak
	checkinstall --install=no --pkgversion="$(OPENCV_VERSION)" --maintainer="$(USER)" --nodoc --pkgname="opencv" --provides="opencv" --deldesc=yes --delspec=yes --backup=no --fstrans=yes --default\
		--requires="libdc1394-22-dev,libv4l-dev,libavcodec-dev,libavutil-dev,libavformat-dev,libavutil-dev,libswscale-dev,libx264-dev,libeigen3-dev,libgtk2.0-dev,libgstreamer1.0-dev,libgstreamer-plugins-base1.0-dev,libtbb-dev,libgtkglext1,libilmbase-dev,libjbig-dev,liblzma-dev,libopenexr-dev,libtiff5-dev,libtiffxx5"\
		--replaces="libopencv-dev"\
		 make -C opencv/release/ install -j $$(( $$(nproc) - 1 )) -l $$(nproc)
	rm description-pak
	mv opencv_*_*.deb opencv.deb

install: opencv.deb
	sudo dpkg -i opencv.deb
	sudo ldconfig

uninstall:
	sudo dpkg -r opencv

clean:
	rm -rf opencv/release

mrproper:
	rm -rf opencv/ opencv_contrib/ 

.PHONY: dep-graphic clean mrproper uninstall 
