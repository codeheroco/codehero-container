#! /usr/bin/env sh

sleep 30

apt-add-repository "deb http://archive.ubuntu.com/ubuntu $(lsb_release -sc) main universe"
add-apt-repository "deb http://archive.ubuntu.com/ubuntu $(lsb_release -sc)-updates main universe"
sudo apt-get update

sudo apt-get install -y curl wget bash libyaml-dev libreadline6-dev \
                         libncurses5-dev libssl-dev libgdbm-dev \
                         libqdbm-dev libffi-dev libz-dev libgmp-dev \
                         build-essential autoconf ca-certificates \
                         systemtap vim git tar libxml2-dev libxslt-dev \
                         libcurl4-openssl-dev nginx
