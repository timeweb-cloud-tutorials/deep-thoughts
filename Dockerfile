ARG NODE_VERSION=20

FROM node:${NODE_VERSION}-alpine

ARG DATABASE_URL
ENV DATABASE_URL ${DATABASE_URL}

WORKDIR /app
COPY package.json package-lock.json ./
RUN npm install

COPY . .

RUN npx prisma migrate deploy
RUN npx prisma generate

RUN npm run build
RUN npm prune

ENV PORT=3000

CMD ["node", "/app/.output/server/index.mjs"]

EXPOSE 3000