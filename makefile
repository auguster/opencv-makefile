all: install

update: | opencv opencv_contrib
	cd opencv/ && git pull origin master
	cd opencv_contrib/ && git pull origin master

dep:
	sudo apt-get install -y cmake git checkinstall build-essential libdc1394-22-dev libv4l-dev libavcodec-dev libavutil-dev libavformat-dev libavutil-dev libswscale-dev libx264-dev libeigen3-dev libgtk2.0-dev libgstreamer1.0-dev libgstreamer-vaapi1.0-dev libtbb-dev libgtkglext1 libilmbase-dev libjasper-dev libjbig-dev liblzma-dev libopenexr-dev libtiff5-dev libtiffxx5
	
dep-graphic: dep
	sudo apt-get install -y libqt4-dev libqt4-opengl-dev

opencv_contrib:
	git clone https://github.com/itseez/opencv_contrib.git

opencv:
	git clone https://github.com/itseez/opencv.git
	git checkout 3.0.0-beta

opencv/release: | opencv
	mkdir opencv/release

opencv/release/Makefile: | opencv/release opencv_contrib
	make clean #necessary to make sure old configuration files are not present
	make opencv/release
	cd opencv/release/; cmake -D CMAKE_BUILD_TYPE=RELEASE -DOPENCV_EXTRA_MODULES_PATH=../../opencv_contrib/modules $(options) ..

opencv/release/lib/libopencv_core.so: build

build: opencv/release/Makefile
	make -C opencv/release -j $$(( $$(nproc) - 1 )) -l $$(nproc)

opencv.deb: opencv/release/lib/libopencv_core.so
	echo "OpenCV library compiled from git repository along with the contrib" > description-pak
	sudo checkinstall --install=no --maintainer="$(USER)" --nodoc --pkgname="opencv" --provides="opencv" --deldesc=yes --delspec=yes --backup=no --fstrans=yes --default\
		--requires="libdc1394-22-dev,libv4l-dev,libavcodec-dev,libavutil-dev,libavformat-dev,libavutil-dev,libswscale-dev,libx264-dev,libeigen3-dev,libgtk2.0-dev,libgstreamer1.0-dev,libgstreamer-vaapi1.0-dev,libtbb-dev,libfaac0,libgtkglext1,libilmbase-dev,libjasper-dev,libjbig-dev,liblzma-dev,libopenexr-dev,libtiff5-dev,libtiffxx5"\
		--replaces="libopencv-dev"\
		 make -C $(PWD)/opencv/release/ install
	rm description-pak
	sudo mv opencv_*_*.deb opencv.deb

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
