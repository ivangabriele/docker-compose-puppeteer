FROM node:10-slim

ARG API_URI
ENV API_URI=$API_URI

COPY ./.babelrc /app/.babelrc
COPY ./next.config.js /app/next.config.js
COPY ./package.json /app/package.json
COPY ./yarn.lock /app/yarn.lock
COPY ./pages /app/pages

WORKDIR /app

RUN yarn --frozen-lockfile && yarn cache clean
RUN yarn build

ENTRYPOINT ["yarn", "start"]
