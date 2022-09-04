# CrimsonTome's Blog
> My personal blog documenting my journey into open-source development alongside other things.  
> Created with 11ty, hosted in a docker container on my VPS
## Development

 - clone the repo
 - run `npm i` to install dependencies
 - npm `run serve`
 - make some changes and watch them update in the browser
 
## Building

### Node

 - run `npm run build`

### Docker

The site can also be built and ran inside a docker container when you are in the base of the repo:
 - `sudo docker build -t crimsontome-blog .`
 - `sudo docker run -itd -p unused-port-number:80 crimsontome-blog`
 - visit `localhost:port` or `ip:port` if you are hosting on a VPS and the site should be available to view

## Dockerfile

```dockerfile
FROM node:10-alpine3.9 as npmpackages
WORKDIR /app
COPY package.json .
RUN npm install

FROM node:10-alpine3.9 as builder
WORKDIR /app
COPY --from=npmpackages /app /app
COPY . .
RUN npm run build

FROM nginx:1.17.10-alpine
RUN rm -r /usr/share/nginx/html/
COPY --from=builder /app/_site/ /usr/share/nginx/html/
```
### Ouroboros

Using a tool like [Ouroboros](https://github.com/pyouroboros/ouroboros), you can automatically update containers without the need for restarts. This site is setup with that so you can (instead of building it yourself like above) with `sudo docker run -d -p unused-port-number:80 crimsontome427:crimsontome-blog`

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md) for information on adding to this repository.

## License

crimsontome-blog is released under the MIT License. The full license text is included in the [LICENSE](LICENSE.md) file in this repository. Tldr legal have a [great summary](https://tldrlegal.com/license/mit-license) of the license if you're interested.
