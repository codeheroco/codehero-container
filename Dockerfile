# -*- mode: sh -*-
# vi: set ft=sh :

##
# Codehero container.
#
# Docker version 0.11.0
#

##
# MISSING:
# - Copy the cron-script

FROM albertogg/ruby-nginx:2.2
MAINTAINER Alberto Grespan "https://twitter.com/albertogg"

ADD nginx.conf /etc/nginx/nginx.conf.new
ADD codehero.co /etc/nginx/sites-available/codehero.co
ADD post-receive /tmp/post-receive
ADD build-script.sh /home/codehero/build-script.sh
ADD crontab-script.sh /home/codehero/crontab-script.sh
ADD runit /tmp/runit

RUN useradd codehero -s /bin/bash -m -U &&\
    usermod -a -G sudo codehero &&\
    echo "codehero:qwerty" | chpasswd &&\
    echo "America/Caracas" | sudo tee /etc/timezone &&\
    sudo dpkg-reconfigure --frontend noninteractive tzdata &&\
    mkdir /var/www &&\
     chown -R codehero:codehero /var/www &&\
    cd /home/codehero &&\
     mkdir codehero-repo.git && cd codehero-repo.git && git init --bare &&\
     mv /tmp/post-receive /home/codehero/codehero-repo.git/hooks &&\
     chmod +x /home/codehero/codehero-repo.git/hooks/post-receive &&\
     chown -R codehero:codehero /home/codehero/codehero-repo.git &&\
    mkdir -p /var/www/logs &&\
    mv /etc/nginx/nginx.conf /etc/nginx/nginx.conf.old &&\
    mv /etc/nginx/nginx.conf.new /etc/nginx/nginx.conf &&\
    ln -s /etc/nginx/sites-available/codehero.co /etc/nginx/sites-enabled/codehero.co &&\
    unlink /etc/nginx/sites-enabled/default &&\
    mkdir -p /var/run/sshd &&\
    mkdir -p /etc/service/cron &&\
    mkdir -p /etc/service/sshd &&\
    mkdir -p /etc/service/nginx &&\
    mv /tmp/runit/cron /etc/service/cron/run &&\
    mv /tmp/runit/sshd /etc/service/sshd/run &&\
    mv /tmp/runit/nginx /etc/service/nginx/run &&\
    chown -R root.root /etc/service/ &&\
    chmod -R 755 /etc/service/ &&\
    touch /home/codehero/build.log &&\
    chown -R codehero:codehero /home/codehero &&\
    chmod +x /home/codehero/build-script.sh &&\
    crontab -u codehero /home/codehero/crontab-script.sh

# Add environment variables
ENV LANGUAGE en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LC_CTYPE en_US.UTF-8

# Expose port 80 in the container
EXPOSE 22
EXPOSE 80

CMD ["/usr/sbin/runsvdir-start"]
