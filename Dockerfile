# syntax=docker/dockerfile:1

FROM node:22-alpine AS base
WORKDIR /app
COPY package.json yarn.lock ./
RUN yarn install
COPY . .

FROM base AS test
ENV NODE_ENV=test
CMD ["node", "src/index.js"]
EXPOSE 3000

FROM node:22-alpine AS production
WORKDIR /app
COPY package.json yarn.lock ./
RUN yarn install --production
COPY . .
CMD ["node", "src/index.js"]
EXPOSE 3000
