FROM node:20-alpine3.17
WORKDIR /usr/src/app
COPY ./CI_CD/nodeapp/package.json ./
RUN npm install
COPY ./CI_CD/nodeapp/index.js ./
EXPOSE 8080
CMD ["node", "index.js"]