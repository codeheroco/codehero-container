# -*- mode: sh -*-
# vi: set ft=sh :

##
# Codehero container.
#
# Docker version 1.0.0
#

FROM albertogg/ruby-nginx:2.2.1
MAINTAINER Alberto Grespan "https://twitter.com/albertogg"

ADD nginx /tmp/nginx
ADD runit /tmp/runit
ADD build-script.sh /home/codehero/build-script.sh
ADD crontab-script.sh /home/codehero/crontab-script.sh

RUN useradd codehero -s /bin/bash -m -U &&\
    usermod -a -G sudo codehero &&\
    echo "codehero:qwerty" | chpasswd &&\
    echo "America/Caracas" | sudo tee /etc/timezone &&\
    sudo dpkg-reconfigure --frontend noninteractive tzdata &&\
    mv /etc/nginx/nginx.conf /etc/nginx/nginx.conf.old &&\
    mv /tmp/nginx/nginx.conf /etc/nginx/nginx.conf &&\
    mv /tmp/nginx/codehero.co /etc/nginx/sites-available/codehero.co &&\
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
EXPOSE 443

CMD ["/usr/sbin/runsvdir-start"]
