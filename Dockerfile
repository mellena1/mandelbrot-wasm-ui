FROM node:14.5.0 as builder

WORKDIR /app

COPY . .
RUN npm install
RUN npm run build

FROM nginx:alpine

# add wasm mime type to nginx config
RUN sed -i '/types {/a application/wasm wasm;' /etc/nginx/mime.types
COPY --from=builder /app/dist /usr/share/nginx/html
