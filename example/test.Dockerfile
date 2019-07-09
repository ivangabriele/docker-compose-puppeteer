# This image is used by to run the e2e test on the CI or simulate the CI run locally.

FROM igabriele/docker-compose-puppeteer

COPY ./features /app/features
COPY ./package.json /app/package.json
COPY ./yarn.lock /app/yarn.lock

RUN yarn --frozen-lockfile && yarn cache clean

ENTRYPOINT ["yarn", "test:e2e"]
