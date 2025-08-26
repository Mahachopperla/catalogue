FROM node:20-alpine3.21 AS builder
WORKDIR /opt/server
COPY package.json ./
COPY *.js ./
RUN npm install


FROM node:20-alpine3.21
RUN addgroup -S roboshop && adduser -S roboshop -G roboshop
USER roboshop
WORKDIR /opt/server
COPY --from=builder --chown=roboshop:roboshop /opt/server /opt/server  
#we are copying build files from previous stage and making roboshop system user as owner of the folder
CMD ["node","server.js"]


# once nodejs installed we'll download app content to /app in doc. but we know linux folder structure in which
# 3rd party applications should be stored in /opt
# so from now we are going to follow better practise