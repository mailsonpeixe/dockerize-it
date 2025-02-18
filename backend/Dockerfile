FROM node:jod-alpine3.21 AS appbuild
WORKDIR /usr/app/

COPY . .
RUN npm i && npm run build

FROM node:jod-alpine3.21
WORKDIR /usr/app/

COPY package.json package-lock.json tsconfig.json ./
COPY --from=appbuild /usr/app/dist ./dist

RUN npm i --only=production

EXPOSE 3000

ENTRYPOINT ["node", "dist/index"]
