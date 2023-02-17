---
title: VPS setup 2, electric boogaloo
description: An update on services I'm running on my VPS
date: 2022-09-04
tags:
  - self-hosting
  - linux
  - vps-series
layout: layouts/post.njk
---

![](/img/cloud.png)

## Preface

Back in July, I wrote a post detailing [what I run on my VPS](https://blog.crimsontome.com/posts/my-current-vps-setup), some things have changed since then so I thought I'd come back with an update. If you haven't read the previous post I suggest you do. p.s. Sorry in advance for any awful puns.

## A change to be made

Firstly, I switched VPS providers from Digital Ocean (DO) to [OVH](ovhcloud.com/). This was for a few reasons, the prices for droplets at DO were going up, meaning my free credits from the [GitHub student developer pack](https://education.github.com/pack) would not last me as long as I first thought. In addition to this, at around the time the price increase was announced OVH was having a summer sale, dramatically decreaseing the prices of some of their tiers. The VPS I run now is (on paper) twice as fast as the DO droplet I was using. With a dual core CPU and 4GB of RAM, compared to a single core with 2GB of RAM. The OVH VPS also comes with a larger 50GB SSD. In theory these specs are more than good enough for what I am plan to run and what I currently use it for.

## Saving the (digital) ocean

To save myself a lot of time before I could say goodbye to my Digital Ocean droplet, I had to back up my important files so I could have access to them when I switched to OVH. To accomplish this I saved them to either public or private Git repositories on GitHub (Yes I know I could have probably done it much quicker with `scp` but 🤫).

## Hello world - again

I decided to choose [Ubuntu Server 22.04](https://ubuntu.com/download/server) for the new server as I had used that with the DO one, and have had experience with the Ubuntu ecosystem before. Next I had setup my user account, allowed access from my laptop via SSH keys, disabled root and password authenticated SSH and set up [sshguard](https://sshguard.net/) - You can install sshguard with `sudo apt install sshguard` on Debian based distros like Ubuntu, and should be available in most package managers - all of this is probably a bit overkill 🤔. Then it was time to recover my DO files.

## Gitting my files back

To clone all the repos I needed to get back up and running, I uploaded an SSH key to github to authenticate the cloning of my private repositories. There is a guide to adding SSH keys to GitHub [here](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/adding-a-new-ssh-key-to-your-github-account). You can then append the following to your `.gitconfig` file to prioritise using SSH for git actions.

```shell
[url "git@github.com:"]
        insteadOf = https://github.com/
[url "ssh://git@github.com:"]
        insteadOf = https://github.com/

```

There is however perhaps a more efficient way of doing this, instead of manually cloning all of your repos one by one, using the [GitHub CLI](https://cli.github.com/) and a small shell script. Once `gh` is linked to your GitHub account you can run the following script to clone every repo you own.

```shell
gh repo list --limit num-of-repos |awk '{print $1}' | xargs -L1 gh repo clone
```

Once all my repos had been cloned, I moved them to their appropriate directories and could more or less just run them as I would normally with minimal tweaking. The main things that needed work was Cloudflare DNS and Nginx Proxy Manager but that was just updating the IP address to the new server.

## What has stayed the same

I am still running [Nginx Proxy Manager](https://nginxproxymanager.com/) to manage subdomains of my site and [lock sites that don't come with their own authentication methods](https://blog.crimsontome.com/posts/locking-sites-with-nginx-proxy-manager/).

I still run my blog on the new server (of course), built with [11ty](https://www.11ty.dev/) and containerised with [Docker](https://www.docker.com/).

I still run an open source version of Linktree on my server called [littlelink](https://github.com/techno-tim/littlelink-server), you can see it [here](https://links.crimsontome.com/) though it isnt always kept up to date - oops.

My [git server](https://git.crimsontome.com) is still alive but doesn't see much use, and is only really used to store very important mirrors of repos from GitHub.

## What has changed

### Saying goodbye

I no longer run a [PrivateBin](https://privatebin.info/) server as I could never get it to function properly, but am still looking for other similar variations. I'll get one to work eventually.

I have also stopped using [Dashy](https://dashy.to/) and [Netdata](https://github.com/netdata/netdata) for my server dashboard and metrics respectively. I found I didn't have much of a use for the dashboard and NetData was too memory intensive on the old server so I never bothered setting it up on this server, though it would probably work just fine.

### Welcoming the new additions

Perhaps the most helpful addition to my server is [Ouroboros](https://github.com/pyouroboros/ouroboros), it is used to automate the updating of containers. I wrote a [blog post](https://blog.crimsontome.com/posts/automating-container-updates-with-ouroboros/) about it if you are interested.

Instead of NetData's advanced metrics, I decided to go with something much more lightweight called [Glances](https://github.com/nicolargo/glances), it functions quite like `top` but has some more details and can be viewed in a browser too.

As a form of secret manageent, I use [vaultwarden](https://github.com/dani-garcia/vaultwarden/), though this has not seen a lot of use recently, so I may scrap this.

[Uptime Kuma](https://github.com/louislam/uptime-kuma) is used to monitor some sites hosted by friends and Freeside and can be seen [here](https://uptime.crimsontome.com/status/uptime)

### Things I may come back to

- Honeypots including [Honeyport](https://github.com/securitygeneration/Honeyport)
- A [factorio map site](https://github.com/ProkopRandacek/FactorioFotograf) inspired by [sbrl's world](https://public.mooncarrot.space/Mazeworld64/)
- A [Spotify profile dashboard](https://github.com/Yooooomi/your_spotify)
- A Discord bot for fetching information about Magic The Gathering cards
