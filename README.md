# CrimsonTome's Blog

> My personal blog documenting my journey into open-source development alongside other things.  
> Created with 11ty, hosted in a docker container on my VPS

[![CI](https://github.com/CrimsonTome/crimsontome-blog/actions/workflows/node%20CI.yml/badge.svg)](https://github.com/CrimsonTome/crimsontome-blog/actions/workflows/node%20CI.yml)
[![Publish Docker image](https://github.com/CrimsonTome/crimsontome-blog/actions/workflows/docker-publish.yml/badge.svg)](https://github.com/CrimsonTome/crimsontome-blog/actions/workflows/docker-publish.yml)
![Repo Size](https://img.shields.io/github/repo-size/crimsontome/crimsontome-blog)
![Commit Activity /month](https://img.shields.io/github/commit-activity/m/crimsontome/crimsontome-blog)
![Last git commit](https://img.shields.io/github/last-commit/crimsontome/crimsontome-blog)
[![code style: prettier](https://img.shields.io/badge/code_style-prettier-ff69b4.svg?style=flat-square)](https://github.com/prettier/prettier)

- [CrimsonTome's Blog](#crimsontomes-blog)
  - [Development](#development)
  - [Building](#building)
    - [Node](#node)
    - [Docker](#docker)
  - [Dockerfile](#dockerfile)
    - [Ouroboros](#ouroboros)
  - [Contributing](#contributing)
  - [Changelog](#changelog)
  - [License](#license)

## Development

- clone the repo
- run `npm i` to install dependencies
- `npm run serve`
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

```

### Ouroboros

Using a tool like [Ouroboros](https://github.com/pyouroboros/ouroboros), you can automatically update containers without the need for restarts. This site is setup with that so you can (instead of building it yourself like above) with `sudo docker run -d -p unused-port-number:80 crimsontome427:crimsontome-blog`

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md) for information on adding to this repository.

## Changelog

Run `./changelog` to generate the changelog after your commit, then `git add . && git commit --amend --no-edit ` to generate the changelog  
The changelog is available [here](CHANGELOG.md)

## License

crimsontome-blog is released under the MIT License. The full license text is included in the [LICENSE](LICENSE.md) file in this repository. Tldr legal have a [great summary](https://tldrlegal.com/license/mit-license) of the license if you're interested.
