# Docker Compose Puppeteer

A Docker image based on Debian including:
- **Docker**
- **Docker Compose
- **puppeteer** (locally in `/app`)
- **node.js**
- **npx** (globally)
- **Yarn** (globally)

## Why

This is mostly useful to highly increase the speed of your CI runs as well as reducing the pain configuring them,
supposing that you are used to handle your bundles (api, client, databases, etc) via docker-compose.

## Get started

**This docker image has a few important requirements:**

- The project files must be copied whithin the `/app` directory whithin your e2e test container which is used as the
default working directory.
- You must use [dind](https://hub.docker.com/_/docker#start-a-daemon-instance) in order to access the host Docker daemon
whithin the container.
- You must use the launch puppeteer with these arguments:
`puppeteer.launch({ args: ['--no-sandbox', '--disable-setuid-sandbox'] })`.

### Example

**In order to understand how to integrate this image whithin your CI and avoid most caveats, I strongly advise you to
check [the example project files](https://github.com/ivangabriele/docker-compose-puppeteer/blob/master/example).**

The most important files are:

- [Gitlab CI config](https://github.com/ivangabriele/docker-compose-puppeteer/blob/master/.gitlab-ci.yml)
- [Docker Compose config](https://github.com/ivangabriele/docker-compose-puppeteer/blob/master/example/docker-compose.yml)
- [Test Dockerfile](https://github.com/ivangabriele/docker-compose-puppeteer/blob/master/example/test.Dockerfile)

and here is how to simulate the CI run locally:

- [CI simulation script](https://github.com/ivangabriele/docker-compose-puppeteer/blob/master/example/scripts/ci/simulate_tests.sh)

### Gitlab CI

Don't forget to add these lines whithin your configuration file in order to
[enable the docker-in-docker features](https://docs.gitlab.com/ee/ci/docker/using_docker_build.html#use-docker-in-docker-executor):

**.gitlab-ci.yml**

```
  image: igabriele/docker-compose-puppeteer
  services:
    - docker:dind
  variables:
    DOCKER_DRIVER: overlay2
    DOCKER_HOST: tcp://docker:2375
```

Check [the example project configuration](https://github.com/ivangabriele/docker-compose-puppeteer/blob/master/.gitlab-ci.yml)
to get some inspiration.

### Travis CI

_In progress…_

<!--
## Versions

### latest

The [master docker file](https://github.com/ivangabriele/docker-compose-puppeteer/blob/master/Dockerfile) at the root of
the Github repository.

### d18-dc1-n10-y1

- Docker v18.09.7
- docker-compose v1.24.1
- node.js v10.16.0
- Yarn v1.16.0
-->
