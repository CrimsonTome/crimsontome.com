---
title: Self host your password manager!
description: How and why you should self host your own password manager
date: 2023-01-01
tags:
  - self-hosting
  - security
layout: layouts/post.njk
---

tldr: password managers provided by large companies, while convenient and come with some very nice faeatures are very much vulnerable to having data breaches and can have security issues. You don't want that.

You've seen the news, it seems like every other week a company has a data breach or vulnerability discovered. For example LastPass had an incident in August 2022. Whilst the company did a good job of disclosing the fact they had a breach, saying only development material was compromised and that they had no reason to believe any passwords of its users had been stolen, in December 2022 they updated their [post](https://blog.lastpass.com/2022/12/notice-of-recent-security-incident/) stating that some personal information was obtained, such as 'end-user names, billing addresses, email addresses, telephone numbers, and the IP addresses from which customers were accessing the LastPass service'. Whilst this data isn't classed as critical, it is still data that could be used to aid in another attack on an individual or company. However those that use a weak master password could still have their database [brute forced](https://en.wikipedia.org/wiki/Brute-force_attack). There are other examples that you can find online with a quick Google search.

So what can you do about this? Don't rely on companies to provide security for you. [Self host](<https://en.wikipedia.org/wiki/Self-hosting_(web_services)>) your own password manager. This can either be via an application on your computer or a web based client on a [VPS](https://en.wikipedia.org/wiki/Virtual_private_server). I can recommend [Vaultwarden](https://github.com/dani-garcia/vaultwarden) for hosting on a server. You can install it using [Docker](https://docker.com) with the following commands:

```sh
docker pull vaultwarden/server:latest
docker run -d --name vaultwarden -v /vw-data/:/data/ -p a-port-that-is-not-in-use:80 vaultwarden/server:latest
```

If you are new to Docker, you can follow [this guide](https://kieranrobson.com/docs/docker-and-docker-compose/) by Kieran Robson on installing Docker and Docker Compose.  
For desktop use I recommend using the cross-platform [KeePassXC](https://keepassxc.org/). Both will prompt you to enter in a master password, for those that haven't used a password manager before, this is the one password you will have to remember, think of it as a key to your database filled with passwords. Make sure this is a strong, but memorable password! If you lose this password your database will be unusable to you and if it is too weak it's vulnerable to being brute forced - especially if you are exposing this over the network.
