# Codehero Server Builder

Codehero server image builder for DigitalOcean build using [packer.io][packer].
This project will build a snapshot of Ubuntu 14.04 x86 with all needed
dependencies and configuration for the Codehero static blog to work.

## How to create a new image

**note:** you need the packer binary installed in your machine in order to be
able to build the image. You also need to create an API Token in the
DigitalOcean admin panel.

First validate that the `packer.json` script is correct using `packer validate`

```bash
$ packer validate packer.json
```

Then export the previously generated API token as `DIGITALOCEAN_API_TOKEN` in
your computer and build the new image using `packer build` command.

```bash
$ export DIGITALOCEAN_API_TOKEN="your_api_token"
$ export packer build packer.json
```

When packer finishes building the image a new "snapshot" should be created with
the codehero name and a timestamp, e.g. `codehero-1422840869`.

## License MIT

The license is MIT

[packer]: https://packer.io/
