FROM node:10-slim

ENV API_PORT=

COPY ./.babelrc /app/.babelrc
COPY ./package.json /app/package.json
COPY ./src /app/src
COPY ./yarn.lock /app/yarn.lock

WORKDIR /app

RUN yarn --frozen-lockfile && yarn cache clean
RUN yarn build

ENTRYPOINT ["yarn", "start"]
