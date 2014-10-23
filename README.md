opencv-makefile
===============

An automatic makefile to retrieve, configure, build and install OpenCV for Ubuntu

just run _make_ and let the makefile do its job

# available targets:

* dep: uses apt-get install to retrieve opencv's basic dependancies (prompts for root)
* dep-graphic: uses apt-get install to retrieve opencv's basic dependancies and graphical interface (prompts for root)
* opencv/release/Makefile: runs cmake to configure opencv with whatever it detects, you might want to do it manually to add/remove CUDA support (or other lib)
* build: builds opencv using the maximum minus 1 available CPU core
* install: installs opencv system-wide (depends on cmake prefix), prompts for root depending on prefix
* clean: remove built file and configuration
* mrproper: removes opencv and opencv_contrib
