# Stage: build
FROM node:alpine AS build

ARG APP_NAME
WORKDIR /usr/src
COPY ["package*.json", "nx.json", "./"]
RUN npm install
COPY . .
RUN npx nx run ${APP_NAME}:build:production --skipNxCache

# Stage: production
FROM fholzer/nginx-brotli:latest
WORKDIR /usr/share/nginx/html
RUN rm -rf ./*

ARG APP_NAME

COPY --from=build /usr/src/dist/apps/${APP_NAME} /usr/share/nginx/html
COPY nginx/nginx.default.conf /etc/nginx/conf.d/default.conf
ENTRYPOINT ["nginx", "-g", "daemon off;"]
