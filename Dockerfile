FROM node:18-alpine3.15 as npmpackages
WORKDIR /app
COPY package.json .
RUN npm install

FROM node:18-alpine3.15 as builder
WORKDIR /app
COPY --from=npmpackages /app /app
COPY . .
RUN npm run build

FROM nginx:1.17.10-alpine
RUN rm -r /usr/share/nginx/html/
COPY --from=builder /app/_site/ /usr/share/nginx/html/

