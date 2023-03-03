#!/usr/bin/env sh

git fetch origin
git checkout main
git reset --hard origin/main
git pull
cd src/blog
zola build
