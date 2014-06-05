# Codehero Container using Docker

This is the Codehero container

**Container is very unstable and may not run.**

## Run the container locally

We are missing the **nginx port** and the script to auto run everything

```bash
$ docker run -i -t -p 2222:22 albertogg/codehero-container /bin/bash
$ passwd codehero # add some password
$ /usr/sbin/sshd -D
```

Run the docker container in daemon mode (production mode)

```bash
$ docker run -d -p 2222:22 -p 80:80 albertogg/codehero-container
```

To push some code to the container

- Add the remote first
- Push later

```bash
$ git add remote deploy ssh://codehero@ip-address:2222/home/codehero/codehero-repo.git
$ git push deploy master
```

## License MIT

The license is MIT

## ToDo

- Script to run services container when container is being launched.
  - Can be achieved using runit, mon, simple bash or w/e.
  - We need to run, nginx, cron and any other service we need.
- Cron script that will build the whole site everyday at 00:00.
  - We may need a separate script to build that will be called from the crontab
- The rest of the things are container related and are inside the Dockerfile
