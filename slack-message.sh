#! /usr/bin/env sh

message=$1
token=$SLACK_TOKEN
channel=#general

curl -X POST --data-urlencode 'payload={"channel": "'$channel'", "username": "Mon", "text": "'"${message}"'", "icon_emoji": ":rotating_light:"}' https://codehero.slack.com/services/hooks/incoming-webhook?token=$token
