# -*- mode: sh -*-
# vi: set ft=sh :

##
# Codehero container.
#
# Docker version 0.11.0
#

##
# MISSING:
# - Commands that will be applied when executed the container:
#     This can be achieved with runit, mon or w/e, but we need to run:
#       - Run nginx
#       - Run cron
#
# - Ports, determine which ports need to be open
# - Copy the cron-script
# - Copy the git hook to build with every push
# - Expose the right ports for ssh and nginx (2222, 8080, 80)
# - Configure Time Zone info if possible

# Copy over the nginx configuration to container

FROM albertogg/ruby-nginx:2.2
MAINTAINER Alberto Grespan "https://twitter.com/albertogg"

# Remove this two lines after the codehero-jekyll is open sourced
RUN mkdir /tmp/ssh
ADD ssh /tmp/ssh

ADD nginx.conf /etc/nginx/nginx.conf.new
ADD codehero.co /etc/nginx/sites-available/codehero.co

RUN useradd codehero -s /bin/bash -m -U &&\
    mv /tmp/ssh /home/codehero/.ssh &&\
    touch /home/codehero/.ssh/known_hosts &&\
    ssh-keyscan github.com >> /home/codehero/.ssh/known_hosts &&\
    mkdir /var/www && cd /var/www &&\
    chown -R codehero:codehero /var/www &&\
    sudo -u codehero git clone git@github.com:albertogg/codehero-jekyll.git --depth 1 &&\
    chown -R codehero:codehero /var/www/codehero-jekyll &&\
    mv /etc/nginx/nginx.conf /etc/nginx/nginx.conf.old &&\
    mv /etc/nginx/nginx.conf.new /etc/nginx/nginx.conf &&\
    ln -s /etc/nginx/sites-available/codehero.co /etc/nginx/sites-enabled/codehero.co &&\
    unlink /etc/nginx/sites-enabled/default

# Expose port 80 in the container
#EXPOSE 80
#EXPOSE 2222

# Add environment variables
ENV LANGUAGE en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LC_CTYPE en_US.UTF-8
