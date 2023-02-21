---
title: My current VPS setup
description: What I'm running on my VPS
date: 2022-06-09
tags:
  - self-hosting
  - linux
  - vps-series
layout: layouts/post.njk
---

A few months ago I made a [post](https://blog.crimsontome.com/posts/PVE/) on Proxmox and what I run/ran on my physical home server, and whilst I have now fixed my hardware issues (by geting completely different hardware) I am yet to recreate all my VMs on that machine. So in the meantime, using my [GitHub Student](https://education.github.com/pack) credits I have setup a VPS with [DigitalOcean](https://www.digitalocean.com/products/droplets).

## What I run

### Blog

My blog (what you are currently reading) is hosted on my droplet using [11ty](https://www.11ty.dev/) and [Docker](https://www.docker.com/). It is essentially the same as what I have done previously except instead of deploying to netlify I have Docker build the site and expose it on my server with this Dockerfile

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

EXPOSE 5000
```

### Git server

My Git server at https://git.crimsontome.com (as reccomended by a good friend [Starbeamrainbowlabs](https://starbeamrainbowlabs.com/)) is created using [Gitea](https://gitea.io/en-us/). I use it to host most of my private repositories and store backups of some important repos from GtiHub, just in case. I had some issues setting this up in a Docker container so i just run the standalone package.

### Links

https://links.crimsontome.com is created from a [littlelink](https://github.com/techno-tim/littlelink-server) container. It is an open-source self-hosted alternative to services like LinkTree. It contains links to most of my public services and is ran through this docker-compose file

```yml
version: "3.0"
services:
  littlelink-server:
    image: ghcr.io/techno-tim/littlelink-server:latest
    # dockerhub is also supported timothystewart6/littlelink-server
    # image: timothystewart6/littlelink-server:latest
    container_name: littlelink-server
    environment:
      - META_TITLE=CrimsonTome
      - META_DESCRIPTION=Linux Sysadmin and FOSS Enthusiast
      - META_AUTHOR=CrimsonTome
      - LANG=en
      - META_INDEX_STATUS=all
      - OG_SITE_NAME=CrimsonTome
      - OG_TITLE=CrimsonTome
      - OG_DESCRIPTION=The home of CrimsonTome
      - OG_URL=https://crimsontome.com
      - GA_TRACKING_ID=G-XXXXXXXXXX
      - THEME=Dark
      - AVATAR_URL=https://https://avatars.githubusercontent.com/u/64846840?v=4
      - AVATAR_2X_URL=https://https://avatars.githubusercontent.com/u/64846840?v=4
      - AVATAR_ALT=
      - NAME=CrimsonTome
      - BIO=The home of CrimsonTomes links
      # use ENV variable names for order, listed buttons will be boosted to the top
      - BUTTON_ORDER=YOUTUBE,TWITCH,TWITTER,GITHUB,INSTAGRAM,DISCORD,FACEBOOK,TIKTOK,PATREON,GEAR,DOCUMENTATION
      # you can render an unlimited amount of custom buttons by adding
      # the CUSTOM_BUTTON_* variables and by using a comma as a separator.
      - CUSTOM_BUTTON_TEXT=Blog,LinkedIn, Git Service, PasteBin Service
      - CUSTOM_BUTTON_URL=https://blog.crimsontome.com,https://www.linkedin.com/in/matt-clark-aa776b1b4/,https://git.crimsontome.com,https://paste.crimsontome.com
      - CUSTOM_BUTTON_COLOR=#000000,#000000,#000000,#000000
      - CUSTOM_BUTTON_TEXT_COLOR=#ffffff,#ffffff,#ffffff,#ffffff
      - CUSTOM_BUTTON_ALT_TEXT=My blog,LinkedIn,Gitea,PrivateBin
      - CUSTOM_BUTTON_NAME=BLOG,LinkedIn,Gitea,PrivateBin
      - CUSTOM_BUTTON_ICON=fas file-alt,fas file-alt,fas file-alt,fas file-alt
      - GITHUB=https://github.com/crimsontome
      - TWITTER=https://twitter.com/ctome427
      - YOUTUBE=https://www.youtube.com/channel/UCrxIJeb-FW_rFBQ19LRZSaQ
      - FOOTER=CrimsonTome © 2022

    ports:
      - 8090:3000
    restart: unless-stopped
    security_opt:
      - no-new-privileges:true
```

### Nginx Proxy Mangager

[Nginx Proxy Manager](https://nginxproxymanager.com/) is a project that 'comes as a pre-built docker image that enables you to easily forward to your websites running at home or otherwise, including free SSL, without having to know too much about Nginx or Letsencrypt'

```yml
version: '3'
services:
  app:
    image: 'jc21/nginx-proxy-manager:latest'
    restart: unless-stopped
    ports:
      - '80:80'
      - '81:81'
      - '443:443'
    volumes:
      - ./data:/data
      - ./letsencrypt:/etc/letsencrypt
```

You can also use it to lock sites that don't come with their own authenticattion. You can read about how to do that [here](https://blog.crimsontome.com/posts/locking-sites-with-nginx-proxy-manager/)

### PrivateBin server

Whilst currently not fully functional, https://paste.crimsontome.com hosts my [PrivateBin](https://privatebin.info/) instance. Like most of my services it runs inside a docker container

```sh
docker run -d --restart="always" --read-only -p 8080:8080 -v $PWD/privatebin-data:/srv/data privatebin/nginx-fpm-alpine
```

### Dashy

[Dashy](https://dashy.to/) can be ran in a docker container, but some plugins _do not_ work whilst Dashy is in one, so I am using npm to build and serve it instead. Once you are done setting up dashy

```sh
git clone https://github.com/Lissy93/dashy.git
cd dashy
# make your changes to public/conf
npm run build
npm run start
```

### Server metrics with NetData

I use [NetData](https://github.com/netdata/netdata) to provide server metrics for my dashboard such as CPU, Memory and disk usage, alognside many others
