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
#       - Run sshd as a daemon
#       - Run cron
#
# - Ports, determine which ports need to be open
# - Copy the cron-script
# - Expose the right ports for ssh and nginx (2222, 8080, 80)
# - Add codehero user a password (passwd)
# - Create nginx log folder (/var/www/log)

FROM albertogg/ruby-nginx:2.2
MAINTAINER Alberto Grespan "https://twitter.com/albertogg"

ADD nginx.conf /etc/nginx/nginx.conf.new
ADD codehero.co /etc/nginx/sites-available/codehero.co
ADD post-receive /tmp/post-receive

RUN useradd codehero -s /bin/bash -m -U &&\
    echo "America/Caracas" | sudo tee /etc/timezone &&\
    sudo dpkg-reconfigure --frontend noninteractive tzdata &&\
    mkdir /var/www &&\
     chown -R codehero:codehero /var/www &&\
    cd /home/codehero &&\
     mkdir codehero-repo.git && cd codehero-repo.git && git init --bare &&\
     mv /tmp/post-receive /home/codehero/codehero-repo.git/hooks &&\
     chmod +x /home/codehero/codehero-repo.git/hooks/post-receive &&\
     chown -R codehero:codehero /home/codehero/codehero-repo.git &&\
    mv /etc/nginx/nginx.conf /etc/nginx/nginx.conf.old &&\
    mv /etc/nginx/nginx.conf.new /etc/nginx/nginx.conf &&\
    ln -s /etc/nginx/sites-available/codehero.co /etc/nginx/sites-enabled/codehero.co &&\
    unlink /etc/nginx/sites-enabled/default &&\
    mkdir -p /var/run/sshd

# Expose port 80 in the container
#EXPOSE 80

# Add environment variables
ENV LANGUAGE en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LC_CTYPE en_US.UTF-8

EXPOSE 2222
