FROM node:20-alpine3.17
WORKDIR /usr/src/app
COPY ./nodeapp/package.json ./
RUN npm install
COPY ./nodeapp/index.js ./
EXPOSE 8080
CMD ["node", "index.js"]