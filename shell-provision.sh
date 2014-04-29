#! /usr/bin/env sh

sudo -s

export DEBIAN_FRONTEND=noninteractive

# update packages
apt-get update -y --fix-missing
apt-get -o Dpkg::Options::="--force-confnew" -o Dpkg::Options::="--force-confold" --force-yes -fuy upgrade

echo "deb http://archive.ubuntu.com/ubuntu $(lsb_release -sc) main universe" > /etc/apt/sources.list
apt-get update -y
apt-get clean
