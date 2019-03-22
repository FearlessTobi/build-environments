FROM ubuntu:18.04
MAINTAINER yuzu
RUN useradd -m -s /bin/bash yuzu
RUN apt-get update && apt-get -y full-upgrade
RUN apt-get install --no-install-recommends -y build-essential libsdl2-dev libssl-dev python qtbase5-dev qtwebengine5-dev libqt5opengl5-dev wget git ccache cmake ninja-build
