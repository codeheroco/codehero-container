# Codehero Container using Docker

This is the Codehero container

**Container is very unstable and may not run.**

## License MIT

The license is MIT

## ToDo

- Script to run services container when container is being launched.
  - Can be achieved using runit, mon, simple bash or w/e.
  - We need to run, nginx, cron and any other service we need.
- Cron script that will build the whole site everyday at 00:00.
  - We may need a separate script to build that will be called from the crontab
- Git hook to build with every push.
- The rest of the things are container related and are inside the Dockerfile
