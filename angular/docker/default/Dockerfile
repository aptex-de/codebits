# Stage: build
FROM node:alpine AS build
WORKDIR /usr/src
COPY ["package*.json", "./"]
RUN npm install
COPY . .
RUN npm run build

# Stage: production
FROM nginx:latest
COPY --from=build /usr/src/dist/my-app /usr/share/nginx/html
