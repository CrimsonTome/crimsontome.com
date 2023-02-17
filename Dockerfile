FROM ghcr.io/getzola/zola:v0.17.0 as zola
WORKDIR /site  
COPY src/blog/ /site
CMD ["build"]

