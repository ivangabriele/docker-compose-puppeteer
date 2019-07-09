# Docker Compose Puppeteer

A Docker image based on Debian including:
- Docker
- Docker Compose
- node.js
- Yarn
- puppeteer

## Why

This is mostly useful for CI e2e tests like Gitlab CI or Travis, supposing that you handle your bundles (api, client,
databases, etc) via Docker Compose.

## Get started

**This docker image has a few important requirements:**

- You must include `puppeteer` as a dependency in your package.json.
- The root project files mst be copied into the `/app` directory which is used as the container working directory.
- You must user []()

### Locally

Please [read this](https://hub.docker.com/_/docker#start-a-daemon-instance).

### Gitlab CI

Don't forget to add these lines whithin your configuration file:

**.gitlab-ci.yml**

```
  services:
    - docker:dind
  variables:
    DOCKER_HOST: tcp://localhost:2375
```

## Versions

### latest

The [master docker file](https://github.com/ivangabriele/docker-compose-puppeteer/blob/master/Dockerfile) at the root of
the Github repository.

### d18-dc1-n10-y1

- Docker v18.09.7
- docker-compose v1.24.1
- node.js v10.16.0
- Yarn v1.16.0
