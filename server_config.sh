#! /usr/bin/env sh

# create codehero user and group with id 1040 and bash as the default shell
useradd codehero -u 1040 -s /bin/bash -m -U
usermod -a -G sudo codehero
groupmod -g 1040 codehero

# configure the timezone to our local
echo "America/Caracas" | sudo tee /etc/timezone
sudo dpkg-reconfigure --frontend noninteractive tzdata

# move the uploaded build and cron scripts to the codehero home
mv /tmp/build-script.sh /home/codehero/build-script.sh
mv /tmp/crontab-script.sh /home/codehero/crontab-script.sh

# make the script executable
chmod +x /home/codehero/build-script.sh

# add the crontab script to crontab
crontab -u codehero /home/codehero/crontab-script.sh

# make codehero owner of its home
chown -R codehero:codehero /home/codehero

# move and apply the nginx configuration
mv /etc/nginx/nginx.conf /etc/nginx/nginx.conf.old
mv /tmp/nginx/nginx.conf /etc/nginx/nginx.conf
mv /tmp/nginx/codehero.co /etc/nginx/sites-available/codehero.co
ln -s /etc/nginx/sites-available/codehero.co /etc/nginx/sites-enabled/codehero.co
unlink /etc/nginx/sites-enabled/default
