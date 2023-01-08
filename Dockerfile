# Builder

FROM node:18-alpine as builder
WORKDIR /app

RUN apk add --no-cache yarn
COPY package.json .
RUN yarn
COPY . .

RUN yarn build

CMD ["yarn", "dev"]

# Runner

FROM node:18-alpine as runner
WORKDIR /app

COPY --from=builder /app/.next .
COPY --from=builder /app/public ./standalone/public

EXPOSE 3000
CMD [ "node", "./standalone/server.js" ]
