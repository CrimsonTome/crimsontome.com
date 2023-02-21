---
title: Automating container updates with Ouroboros
description: How to automate container updates with Ouroboros
date: 2022-08-25
tags:
  - docker
  - linux
  - self-hosting
  - github
  - how-to
---

![image](https://user-images.githubusercontent.com/64846840/188291755-3b17cbfb-667b-43cd-97c4-748a1d9f769a.png)

A few months ago, I started learning about containers using Docker. This has certainly been a fun experience overall (though sometimes frustrating 😛). One _issue_ with this is rebuilding the container upon every update when you want to deploy the new image.

There is however a solution to this problem thankfully. A good friend [Kieran](https://github.com/kieranrobson "Kieran's GitHub account"), who also started learning Docker at around the same time as myself introduced me to [Ouroboros](https://github.com/pyouroboros/ouroboros "Ouroboris Git repo"). Kieran uses this to keep his many Discord bots up to date without having to manually rebuild and bring up each container over and over again, and this seems to work pretty well. It is unfortunate that the project has now been abandonned (last commit in 2020). However the software still functions as it should. The following guide assumes you have some basic experience with Docker. If you have no experience then there are a couple of good posts by Kieran Robson [here](https://docs.kieranrobson.com/tags/docker/) on how to setup docker and portainer.

To set this up you will need:

- Docker
- a [DockerHub](https://hub.docker.com/) account
- A GitHub repo with a functioning `Dockerfile` in

<break>

## Docker CI

- go to `https://github.com/your-username/your-repo/actions/new` and click on `set up a workflow yourself`.
- remove the existing yaml in the auto generated file and copy the contents from below into it

```yaml
# This workflow uses actions that are not certified by GitHub.
# They are provided by a third-party and are governed by
# separate terms of service, privacy policy, and support
# documentation.

name: Publish Docker image

on:
  push:
    branches:
      - "main"

jobs:
  push_to_registries:
    name: Push Docker image to multiple registries
    runs-on: ubuntu-latest
    permissions:
      packages: write
      contents: read
    steps:
      - name: Check out the repo
        uses: actions/checkout@v3

      - name: Log in to Docker Hub
        uses: docker/login-action@f054a8b539a109f9f41c372932f1ae047eff08c9
        with:
          username: ${{ secrets.DOCKERHUB_USERNAME }}
          password: ${{ secrets.DOCKERHUB_PASSWORD }}

      - name: Log in to the Container registry
        uses: docker/login-action@f054a8b539a109f9f41c372932f1ae047eff08c9
        with:
          registry: ghcr.io
          username: ${{ github.actor }}
          password: ${{ secrets.GITHUB_TOKEN }}

      - name: Extract metadata (tags, labels) for Docker
        id: meta
        uses: docker/metadata-action@98669ae865ea3cffbcbaa878cf57c20bbf1c6c38
        with:
          images: |
            $/YOUR-IMAGE-NAME-HERE
            ghcr.io/${{ github.repository }}

      - name: Build and push Docker images
        uses: docker/build-push-action@ad44023a93711e3deb337508980b4b5e9bcdc5dc
        with:
          context: .
          push: true
          tags: ${{ steps.meta.outputs.tags }}
          labels: ${{ steps.meta.outputs.labels }}
```

- the above will build the docker image and push it to the Docker Hub as well as GitHub's registry.
- there are two fields that need editing before this will work. `username: ${{ secrets.DOCKERHUB_USERNAME }}` and `password: ${{ secrets.DOCKERHUB_PASSWORD }}`. These can be configured at `https://github.com/your-username/your-repo/settings/secrets/actions/new` - open this in a new tab. Add your `DOCKERHUB_USERNAME` to one and DOCKERHUB_PASSWORD to another. also change `$/YOUR-IMAGE-NAME-HERE` with an appropriate name and then save. You should end up with something like this

 <break>

<img src="/img/docker-secrets.png"/>

- now go back to the action code and save it
- with any luck after some time you should have something like this in your actions tab

<break>

<img src="/img/workflow.png"/>

## Ouroboros setup

- To run Ouroboros:

```sh
docker run -d --name ouroboros \
  -v /var/run/docker.sock:/var/run/docker.sock \
  ghcr.io/gmt2001/ouroboros
```

- Then with the containers involved:

  - stop the containers
  - run the snippet below, filling in the details you need to

```sh
docker run -d \
--name=INSERT NAME \
-p AN-UNUSED-PORT:THE-PORT-THE-SERVICE-RUNS-ON \
--restart unless-stopped \
DOCKERHUB-USERNAME/IMAGE:TAG
```

Note that the tag used in this workflow is `main`.

With any luck you should now have containers automatically update once you push changes to GitHub.
