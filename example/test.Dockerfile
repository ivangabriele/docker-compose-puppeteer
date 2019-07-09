# This image does only exist to simulate the CI run locally, you may not need it whithin your project:

FROM igabriele/docker-compose-puppeteer

COPY ./features /app/features
COPY ./package.json /app/package.json
COPY ./yarn.lock /app/yarn.lock

RUN yarn --frozen-lockfile && yarn cache clean

ENTRYPOINT ["yarn", "test:e2e"]
