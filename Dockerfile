FROM ubuntu:latest
MAINTAINER Rafi Fajar Hidayat "rafi.fajar@bukalapak.com"
LABEL Name=esp32bleprinter Version=latest
EXPOSE 22/tcp

RUN apt-get update && apt-get install -y  \
    git wget make libncurses-dev flex bison gperf python python-pip python-setuptools python-serial python-cryptography python-future python-pyparsing python-pyelftools \
    lib32ncurses5 \
    default-jre \
    libxext-dev \
    libxrender-dev \
    libxtst-dev \
    libgtk2.0-0 libcanberra-gtk-module \
    g++ libboost-all-dev build-essential gdb

RUN mkdir /root/esp32work \
    && mkdir /root/esp32work/eclipse-workspace

ADD https://developer.arm.com/-/media/Files/downloads/gnu-rm/8-2018q4/gcc-arm-none-eabi-8-2018-q4-major-linux.tar.bz2?revision=d830f9dd-cd4f-406d-8672-cca9210dd220?product=GNU%20Arm%20Embedded%20Toolchain,64-bit,,Linux,8-2018-q4-major /root/esp32work/

RUN tar xf ~/esp32work/gcc-arm-none-eabi-8-2018-q4-major-linux.tar.bz2 -C ../opt/ \
    && chmod -R -w /opt/gcc-arm-none-eabi-8-2018-q4-major

RUN wget --post-data="accept_license_agreement=accepted&non_eu_denied_list=confirmed" https://www.segger.com/downloads/jlink/JLink_Linux_x86_64.deb -P /root/esp32work \
    && dpkg -i /root/esp32work/JLink_Linux_x86_64.deb

RUN mkdir /root/esp32work/xtensa-esp32-elf

ADD https://dl.espressif.com/dl/xtensa-esp32-elf-linux64-1.22.0-80-g6c4433a-5.2.0.tar.gz /root/esp32work

RUN tar -xzf ~/esp32work/xtensa-esp32-elf-linux64-1.22.0-80-g6c4433a-5.2.0.tar.gz -C ../root/esp32work/xtensa-esp32-elf \
    && export PATH="$HOME/root/esp32work/xtensa-esp32-elf/bin:$PATH"

ADD https://mirrors.tuna.tsinghua.edu.cn/eclipse/technology/epp/downloads/release/2019-03/R/eclipse-cpp-2019-03-R-linux-gtk-x86_64.tar.gz /root/esp32work/

RUN tar -xf ~/esp32work/eclipse-cpp-2019-03-R-linux-gtk-x86_64.tar.gz -C ../root \
    && chmod -R a+x /root/eclipse \
    && ln -s /root/eclipse/eclipse /usr/local/bin/eclipse \
    && chmod a+x /usr/local/bin/eclipse \
    && export PATH="$HOME/root/eclipse:$PATH"

RUN rm ~/esp32work/gcc-arm-none-eabi-8-2018-q4-major-linux.tar.bz2 \
    && rm ~/esp32work/xtensa-esp32-elf-linux64-1.22.0-80-g6c4433a-5.2.0.tar.gz \
    && rm ~/esp32work/JLink_Linux_x86_64.deb \
    && rm ~/esp32work/eclipse-cpp-2019-03-R-linux-gtk-x86_64.tar.gz

WORKDIR /root/esp32work
