---
title: Fedora -  a review
description: My take on Fedora
date: 2023-02-13
tags:
  - linux
  - review
layout: layouts/post.njk
---

![](https://www.fedoraproject.org/w/uploads/2/2d/Logo_fedoralogo.png) 

<br>

tldr I quite like it.

## Some background information

As mentioned in my [about](/about/) section, I've been daily driving Linux since August 2021 but have been using it as part of side projects for years before that. I have used a handful of distros before that and tested so many more (perhaps too many - I have around 200 GB of Linux distributions downloaded) in virtual machines. On the day this post goes live, I will have been using Fedora for a year. For those that don't know, Fedora is a community-driven distro that is sponsored by RedHat (the creators of RHEL - a widely used commercial server OS). It is known for keeping up to date when it comes to shipping software (while still being relatively stable when compared to Arch for example) and being committed to distributing packages that are FOSS - though there are third-party repos for software you can't find.  Like a lot of modern Linux distributions, Fedora comes with the GNOME desktop environment by default, which has come a long way in recent years, I prefer KDE plasma myself and there are [spins](https://spins.fedoraproject.org/) with a few other environments available. You can of course just install any of them after doing a minimal install should you wish to.

## What I like

Shipping with a newer kernel was at first the main reason why I switched to Fedora in the first place. Thanks to my laptop having a terrible ACPI implementation it would never wake up from sleep. I could have compiled a newer kernel onto another distribution (I think I was using MX at the time), in fact I tried multiple times. On my laptop it took forever to do so and I'd always miss out on a step or not install a driver. In the end I gave up and as I had been using Fedora at Freeside and liked it, I thought I'd give it a try. It's still on my machine a year later, and the up to date software is also a big plus, I'm not stuck compiling from source code 😛 

## What I don't like

I have found DNF (the package manager) to be rather slow, even a basic search or updating mirrors can take what feels like an age - even on a fast machine with a good internet connection.  
While having up to date versions of software is nice sometimes and I think i've only had one issue with things being too new and breaking. During the Fedora 37 beta, I tried upgrading and found my install of [Pyinfra](https://pyinfra.com/) had broken due to Python being upgraded from 3.10 to 3.11. Reinstalling didn't help but these issues cover the problem [1](https://github.com/pypa/pipx/issues/791)/[2](https://github.com/pypa/pipx/issues/886).