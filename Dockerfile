ARG NODE_VERSION=20
ARG DATABASE_URL

FROM node:${NODE_VERSION}-alpine

ENV DATABASE_URL ${DATABASE_URL}

WORKDIR /app
COPY package.json package-lock.json ./
RUN npm install

COPY . .

RUN npx prisma migrate deploy
RUN npx prisma generate

RUN npm run build
RUN npm run prune

ENV PORT=3000

CMD ["node", "/app/.output/server/index.mjs"]

EXPOSE 3000