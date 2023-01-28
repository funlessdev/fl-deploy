# Deployment with `docker compose`

By default, simply running `docker compose up` works, if an appropriate `.env` file was set up beforehand.

In a rootless installation the following variables must be changed, e.g.:
```
DOCKER_SOCK=/run/user/1001/docker.sock
DOCKER_LIB=~/.local/share/docker/
```

Where the values are the appropriate ones for the underlying system.