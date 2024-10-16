FROM node:latest AS base

RUN apt-get update && apt-get install -y git \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

RUN yarn global add @vue/cli

WORKDIR /home/node/app

FROM base AS build

ENV API_URL=http://localhost/api

COPY ./frontend .
RUN yarn install
RUN yarn build

FROM nginx:alpine

COPY --from=build /home/node/app/dist /usr/share/nginx/html
COPY ./docker/frontend/nginx.prod.conf /etc/nginx/conf.d/default.conf

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
