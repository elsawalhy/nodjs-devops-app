
FROM node:alpine

WORKDIR /usr/src/app

COPY package.json ./

RUN npm install

EXPOSE 8000

COPY . .
 
CMD [ "node" , "app.js" ]

