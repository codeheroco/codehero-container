#! /usr/bin/env bash

PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games

0 0 * * * /home/codehero/build-script.sh > /home/codehero/build.log 2>&1
