FROM nvidia/cuda:11.4.2-cudnn8-devel-ubuntu20.04

ARG DEBIAN_FRONTEND=noninteractive
COPY opencv-cuda:11.4.2-devel-ubuntu20.04.deb opencv.deb
RUN apt update && apt install -y ./opencv.deb cmake pkg-config && apt clean