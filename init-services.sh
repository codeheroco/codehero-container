#! /usr/bin/env bash

mon -d "/usr/sbin/nginx -c /etc/nginx/nginx.conf" -p /home/codehero/processes/pids/nginx.pid -l /home/codehero/processes/logs/nginx.log -E './home/codehero/slack_message.sh "Nginx has exited with error"' -R './home/codehero/slack_message.sh "Nginx has been restarted"'
mon -d "/usr/sbin/cron -f" -p /home/codehero/processes/pids/cron.pid -l /home/codehero/processes/logs/cron.log -E './home/codehero/slack_message.sh "Cron has exited with error"' -R './home/codehero/slack_message.sh "Cron has been restarted"'
mon -d "/usr/sbin/sshd -D" -p /home/codehero/processes/pids/sshd.pid -l /home/codehero/processes/logs/sshd.log -E './home/codehero/slack_message.sh "SSHD has exited with error"' -R './home/codehero/slack_message.sh "SSHD has been restarted"'
