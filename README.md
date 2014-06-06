# Codehero Container using Docker

This is the Codehero container

## Run the container locally

We are missing the **nginx port** and the script to auto run everything

```bash
$ docker run -i -t -p 2222:22 -p 80:80 codehero/codehero-container /bin/bash
```

Run the docker container in daemon mode (production mode)

```bash
$ docker run -d -p 2222:22 -p 80:80 codehero/codehero-container
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
