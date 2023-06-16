FROM node:20-alpine3.17
WORKDIR /usr/src/app
COPY package.json .
RUN npm install
COPY index.js .
EXPOSE 8080
CMD ["node", "index.js"]
