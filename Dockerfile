FROM ubuntu:14.10
MAINTAINER Rémi AUGUSTE <remi.auguste@gmail.com>

RUN apt-get update && apt-get install -q -y \
	wget \
	build-essential

COPY makefile .
RUN make dep && make && make mrproper
