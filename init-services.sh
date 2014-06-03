#! /usr/bin/env sh

mon -d nginx -p processes/pids/nginx.pid -l processes/logs/nginx.log -E './slack_message.sh "Nginx has exited with error"' -R './slack_message.sh "Nginx has been restarted"'
mon -d cron -p processes/pids/cron.pid -l processes/logs/cron.log -E './slack_message.sh "Cron has exited with error"' -R './slack_message.sh "Cron has been restarted"'
mon -d sshd -p processes/pids/sshd.pid -l processes/logs/sshd.log -E './slack_message.sh "SSHD has exited with error"' -R './slack_message.sh "SSHD has been restarted"'
