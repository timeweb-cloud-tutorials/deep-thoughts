# Базовый образ для сборки

ARG NODE_VERSION=20

FROM node:${NODE_VERSION}-alpine AS base

ARG DATABASE_URL
RUN echo ${DATABASE_URL}
ENV DATABASE_URL ${DATABASE_URL}

WORKDIR /app
COPY package.json package-lock.json ./
RUN npm install

FROM base AS builder

COPY . .

RUN npx prisma migrate deploy
RUN npx prisma generate

RUN npm run build

FROM node:${NODE_VERSION}-alpine AS final

WORKDIR /app

COPY --from=builder /app/.output /app/.output

ENV PORT=3000

CMD ["node", "/app/.output/server/index.mjs"]

EXPOSE 3000

