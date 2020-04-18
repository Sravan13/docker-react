# This is about running the react application in the product environment
# Here we are deploying react app in nginx
# In production environment we don't require any dev server we want only files for production env that are finally 
# generated after npm run build . which are in build folder.

#In these we have two phases (build phase and run phase) . First phase is to build react Application and in second phase we 
# copying files generated in first phase  to nginx folder for running the application.

FROM node:alpine as builder
WORKDIR /app
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

FROM nginx
COPY --from=builder /app/build /usr/share/nginx/html 
# the movement when we copy the files from build to nginx all the rest of the files in first phase 
#container will be dropped off

#Note: nginx image don't require start command it automatically start

# docker run -p 8080:80 <imagename>