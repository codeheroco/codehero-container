# Codehero server image

Codehero server image for DigitalOcean build through [packer.io][packer]

## How to create a new image

**note:** you need the packer binary installed in your machine in order to be
able to build the image. You also need to create an API Token in the
digitalocean admin panel.

First validate that the script is correct using `packer validate`

```bash
$ packer validate packer.json
```

Then export the previously generated API token as `DIGITALOCEAN_API_TOKEN` in
your computer and then build the new image using `packer build` command.

```bash
$ export DIGITALOCEAN_API_TOKEN="your_api_token"
$ export packer build packer.json
```

When packer finishes building the image a new "snapshot" should be created with
the codehero name and a timestamp.

## License MIT

The license is MIT

[packer]: https://packer.io/
