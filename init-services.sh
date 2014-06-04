#! /usr/bin/env bash

/usr/sbin/cron -f &

/usr/sbin/sshd -D &

/usr/sbin/nginx -c /etc/nginx/nginx.conf
