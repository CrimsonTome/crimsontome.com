FROM ghcr.io/getzola/zola:v0.17.0 as zola
WORKDIR /site  
COPY src/blog/ /site
CMD ["build"]

FROM nginx:stable-alpine
RUN rm -r /usr/share/nginx/html/
COPY --from=zola /site/_site/ /usr/share/nginx/html/
