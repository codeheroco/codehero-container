#! /usr/bin/env sh

# sleep timer for packer
sleep 30

# additional repos
apt-add-repository "deb http://archive.ubuntu.com/ubuntu $(lsb_release -sc) main universe"
add-apt-repository "deb http://archive.ubuntu.com/ubuntu $(lsb_release -sc)-updates main universe"

# install curl for pulling the nodejs ppa
sudo apt-get install -y curl
curl -sL https://deb.nodesource.com/setup | bash -

# update packages database
sudo apt-get update --fix-missing

# install dependencies
sudo apt-get install -y wget bash libyaml-dev libreadline6-dev \
                        libncurses5-dev libssl-dev libgdbm-dev nodejs \
                        libqdbm-dev libffi-dev libz-dev libgmp-dev \
                        build-essential autoconf ca-certificates \
                        systemtap vim git tar libxml2-dev libxslt-dev \
                        libcurl4-openssl-dev nginx pngcrush imagemagick

# install ruby version 2.1.5 using ruby-build from git
echo 'gem: --no-document' >> /usr/local/etc/gemrc &&\
mkdir /src && cd /src && git clone https://github.com/sstephenson/ruby-build.git &&\
cd /src/ruby-build && ./install.sh &&\
cd / && rm -rf /src/ruby-build && ruby-build 2.1.5 /usr/local &&\
gem update --system &&\
gem install bundler
