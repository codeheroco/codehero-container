# Codehero Container using Docker

This is the Codehero container

## Run the container locally

We are missing the **nginx port** and the script to auto run everything

```bash
$ docker run -i -t -p 2222:22 -p 80:80 -p 443:443 -v /var/www:/var/www codehero /bin/bash
```

Run the docker container in daemon mode (production mode)

```bash
$ docker run -p 2222:22 -p 80:80 -p 443:443 -v /var/www:/var/www -d codehero
```

## License MIT

The license is MIT
