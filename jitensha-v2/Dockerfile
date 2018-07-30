FROM node:boron

RUN mkdir -p /app/jitensha-v2
WORKDIR /app/jitensha-v2

COPY package.json /app/jitensha-v2

RUN npm install

ENV NODE_ENV=dev
COPY . /app/jitensha-v2
