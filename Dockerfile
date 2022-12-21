FROM nvidia/cuda:11.8.0-cudnn8-devel-ubuntu18.04 as build
WORKDIR /var/build

RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive make dep
RUN make options='-DWITH_CUDA=ON -DOPENCV_ENABLE_NONFREE=ON' opencv/release/Makefile
RUN make opencv.deb

FROM nvidia/cuda:11.8.0-cudnn8-devel-ubuntu18.04 as devel
COPY --from=build /var/build/opencv.deb .
RUN DEBIAN_FRONTEND=noninteractive apt-get install -yq ./opencv.deb && rm opencv.deb

FROM nvidia/cuda:11.8.0-cudnn8-runtime-ubuntu18.04 as runtime
COPY --from=build /var/build/opencv.deb .
RUN DEBIAN_FRONTEND=noninteractive apt-get install -yq ./opencv.deb && rm opencv.deb