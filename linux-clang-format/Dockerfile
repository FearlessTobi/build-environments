FROM ubuntu:18.04
MAINTAINER yuzu
RUN useradd -m -s /bin/bash yuzu
RUN apt-get update && apt-get -y full-upgrade
RUN apt-get install -y git clang-format-6.0
