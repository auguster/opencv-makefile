# OpenCV Makefile

An automatic makefile to retrieve, configure, build and install OpenCV for Ubuntu/Debian

Just run `make` and let the makefile do its job

If you want to manually install the deb package you can run:
```bash
sudo apt install ./opencv.deb
```

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

# Non Free
To include the non-free algorithm, add `-DOPENCV_ENABLE_NONFREE=ON` to the options (separated by spaces).

For example:
```bash
make options="-DWITH_CUDA=ON -DOPENCV_ENABLE_NONFREE=ON"
```

# Known Issues
* If the package is already installed, the symlinks for the `.so` files are sometimes not created. One fix seems to uninstall the package before installing it again.
* The dependancies in the package might be outdated or incomplete, this might cause issues if you build the package on one machine and install it on another with apt. You might have some package missing at runtime.

# Changelog

## October 2021
* Bump OpenCV version to 4.5.4
* PkgConfig file is now created to use with cmake, package name is `opencv4`. Check if correctly installed with `pkg-config --libs opencv4`.
* Improved Documentation (including this changelog)
* Instructions for nonfree OpenCV packages

# Author
Dr Rémi AUGUSTE <remi.auguste@gmail.com>