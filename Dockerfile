# Stage 1 — Build React App
FROM node:18-alpine3.20 AS builder
WORKDIR /app
COPY package*.json ./
RUN apk udpate && apk upgrade && apk add --no-cache python3 make g++
RUN npm install
COPY . .
RUN npm run build

# Stage 2 — Run with Nginx

FROM nginx:1.27-alpine3.20
RUN apk update && apk upgrade

COPY --from=builder /app/build /usr/share/nginx/html

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]

