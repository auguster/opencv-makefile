# OpenCV Makefile

An automatic makefile to retrieve, configure, build and install OpenCV for Ubuntu/Debian

Just run `make` and let the makefile do its job

If you want to manually install the deb package you can run:
```bash
sudo apt install ./opencv.deb
```

# What's new

## December 2022
* Dockerfile as been updated to provide a multistage build of OpenCV with Cuda and Cudnn (for developpment and runtime)
* Added a new way to build OpenCV with CUDA using Docker. This provide more portability of OpenCV as it can easily be deployed in a Docker container.
* Release artefacts now provide a ready-to-use deb package for Ubuntu 18.04 with Cuda and Cudnn

## November 2021
* Improving documentation for Nvidia Cuda build

## October 2021
* Bump OpenCV version to 4.5.4
* PkgConfig file is now created to use with cmake, package name is `opencv4`. Check if correctly installed with `pkg-config --libs opencv4`.
* Improved Documentation (including this changelog)
* Instructions for nonfree OpenCV packages

# Available targets:

* `update`: updates the opencv/ and opencv_contrib/ folders with latest git commits
* `dep`: uses apt-get install to retrieve opencv's basic dependancies (prompts for root)
* `dep-graphic`: uses apt-get install to retrieve opencv's basic dependancies and graphical interface (prompts for root)
* `opencv/release/Makefile`: runs cmake to configure opencv with whatever it detects. You can pass options to cmake throught `make options="-DWITH_CUDA=OFF" opencv/release/Makefile`.
* `build`: builds opencv using the maximum minus 1 available CPU core
* `opencv.deb`: uses checkinstall to generate a deb package (prompts for root)
* `install`: installs opencv.deb system-wide (prompts for root)
* `uninstall`: removes opencv.deb from the system (prompts for root)
* `clean`: remove built file and configuration
* `mrproper`: removes opencv and opencv_contrib

# CUDA
To build for Cuda you need to have Cuda already installed and also Cudnn (if you use it).
* Cuda can be found here: https://developer.nvidia.com/cuda-downloads
* Cudnn can be found here: https://developer.nvidia.com/rdp/cudnn-download (requires Nvidia account)

Then build using the following command:
```bash
make options="-DWITH_CUDA=ON"
```

## Build Faster
To build faster, you can specify the specific CUDA architecture you want to build for. It really speeds the build by a lot.
To do this, go on Nvidia's website to figure out the compute capability of your GPU: https://developer.nvidia.com/cuda-gpus

Then give this value to the options by adding `-D CUDA_ARCH_BIN=7.5` (for exemple for a compute capability of 7.5).

Your 

# Non Free
To include the non-free algorithm, add `-DOPENCV_ENABLE_NONFREE=ON` to the options (separated by spaces).

For example:
```bash
make options="-DWITH_CUDA=ON -DOPENCV_ENABLE_NONFREE=ON"
```

# Build Using Docker
In order to build OpenCV for Cuda with Docker you can execute the `build-with-docker.sh` script.
This script requires the Nvidia runtime to be installed and the default runtime of Docker.

At the end of the build, an `opencv.deb` file has been produced.

# Known Issues
* If the package is already installed, the symlinks for the `.so` files are sometimes not created. One fix seems to uninstall the package before installing it again.
* The dependancies in the package might be outdated or incomplete, this might cause issues if you build the package on one machine and install it on another with apt. You might have some package missing at runtime.

# Author
Dr Rémi AUGUSTE <remi.auguste@gmail.com>