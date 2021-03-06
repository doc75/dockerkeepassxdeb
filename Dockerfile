FROM ubuntu:16.04
MAINTAINER Peter Mescalchin <peter@magnetikonline.com>

RUN apt-get update && apt-get -y upgrade && \
	apt-get -y install checkinstall cmake libgcrypt20-dev libqt5x11extras5-dev make qt4-default qtbase5-dev qttools5-dev qttools5-dev-tools zlib1g-dev && \
	apt-get clean

ADD https://www.keepassx.org/releases/2.0.2/keepassx-2.0.2.tar.gz /root/build/
WORKDIR /root/build
RUN tar -xf keepassx-2.0.2.tar.gz

RUN mkdir -p /root/build/keepassx-2.0.2/build
WORKDIR /root/build/keepassx-2.0.2/build
RUN cmake .. && make

RUN echo "magnetikonline: KeePassX v2.0.2" >description-pak && \
	checkinstall -Dy --install=no --nodoc --pkgname=keepassx --pkgversion=2.0.2 make -i install

CMD ["/bin/bash"]
