# This script allow us to simulate a CI run locally.

# Override the .env variable (because localhost is not available within the container):
# https://docs.docker.com/compose/networking/
# https://docs.docker.com/compose/environment-variables/#the-env-file
export API_HOST=api
docker-compose config

# Build all the docker-compose services:
docker-compose build --no-cache

# Launch the e2e tests:
docker-compose up --abort-on-container-exit --exit-code-from test test

# Because we don't want the CI simulation to impact our local tests:
unset API_HOST
# https://docs.docker.com/compose/reference/rm/
docker-compose rm -fs
