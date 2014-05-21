# -*- mode: sh -*-
# vi: set ft=sh :

##
# Codehero container.
#
# Docker version 0.11.0
#

##
# MISSING:
# - Create a codehero user and group
# - Copy the ssh-keys to the codehero user
# - Commands that will be applied when executed the container:
#     This can be achieved with runit, mon or w/e, but we need to run:
#       - Run nginx
#       - Run cron
#
# - Clone over the codehero-jekyll repo to the container
# - Copy the cron-script
# - Copy the git hook to build with every push
# - Expose the right ports for ssh and nginx (2222, 8080, 80)

# Copy over the nginx configuration to container

FROM albertogg/ruby-nginx:2.2
MAINTAINER Alberto Grespan "https://twitter.com/albertogg"

ADD nginx.conf /etc/nginx/nginx.conf.new &&\
    codehero.co /etc/nginx/sites-available/codehero.co

# Apply the nginx configuration on the container including the codehero
# server block
RUN mv /etc/nginx/nginx.conf /etc/nginx/nginx.conf.old &&\
    mv /etc/nginx/nginx.conf.new /etc/nginx/nginx.conf &&\
    ln -s /etc/nginx/sites-available/codehero.co /etc/nginx/sites-enabled/codehero.co &&\
    unlink /etc/nginx/sites-enabled/default

# Expose port 80 in the container
EXPOSE 80

# Add environment variables
ENV LANGUAGE en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LC_CTYPE en_US.UTF-8
