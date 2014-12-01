opencv-makefile
===============

An automatic makefile to retrieve, configure, build and install OpenCV for Ubuntu

just run _make_ and let the makefile do its job

# available targets:

* update: updates the opencv/ and opencv_contrib/ folders with latest git commits
* dep: uses apt-get install to retrieve opencv's basic dependancies (prompts for root)
* dep-graphic: uses apt-get install to retrieve opencv's basic dependancies and graphical interface (prompts for root)
* opencv/release/Makefile: runs cmake to configure opencv with whatever it detects. You can pass options to cmake throught //make options="-DWITH_CUDA=OFF" opencv/release/Makefile//.
* build: builds opencv using the maximum minus 1 available CPU core
* opencv.deb: uses checkinstall to generate a deb package (prompts for root)
* install: installs opencv.deb system-wide (prompts for root)
* uninstall: removes opencv.deb from the system (prompts for root)
* clean: remove built file and configuration
* mrproper: removes opencv and opencv_contrib
