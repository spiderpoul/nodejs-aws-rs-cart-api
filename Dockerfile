FROM node:12 AS base
WORKDIR /app


COPY ./package*.json ./
RUN npm install && npm cache clean --force

COPY . .
RUN npm run build



FROM node:12-alpine
WORKDIR /app
COPY --from=base /app/node_modules ./node_modules
COPY --from=base /app/dist ./dist

USER node
ENV PORT=4000
EXPOSE 4000

CMD ["node", "dist/main.js"]