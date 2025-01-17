# Build-Stage
FROM node:alpine as build // siehe oben
WORKDIR /app
COPY package*.json ./
RUN npm ci
COPY . .
RUN npm run build

# NGINX-Stage mit Brotli 
FROM nginx:alpine
RUN apk add --no-cache brotli
COPY --from=build /app/dist/meine-angular-app /usr/share/nginx/html
COPY nginx-brotli.conf /etc/nginx/nginx.conf
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
