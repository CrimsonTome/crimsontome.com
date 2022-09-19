---
title: An introduction to a potential series on Proxmox
description: An introduction to the Proxmox Virtual Environment
date: 2022-02-10
tags:
  - PVE
  - VMs
  - linux
layout: src/layouts/post.njk
---

This post has been in the works since November 2021, or rather I thought of around then, it hasn't been until February 2022 that I have started drafting anything, as such early details about setting this up may require reading the PVE Documentation more than if I could explain it all. This series is less of a tutorial and more so a collection of my experiences working with the projects. With that in mind let's begin.

# Why am I doing this?

Virtual machines can lead to a good learning experience, whether it’s trying out that new Linux distribution that everyone won’t stop telling you about or testing things out in a safe environment. It’s undeniable that VMs have their usage.

I think my first experience trying out a VM was when I decided to try out Linux ‘properly’ after using a Raspberry Pi for about a year. As a longtime Windows user I felt a bit intimidated with all the variety in what was available to me, and the list of distros available is only expanding. By the reccomendation of a friend who had been using Linux for a few years, I tried out [Linux Mint](https://linuxmint.com/). This is a rather beginner friendly distribution, especially for those coming from Windows like myself.

I don’t remember much about it apart that because of the specs of my laptop, it ran super slowly. So why am i bringing this up now? Recently a member of Freeside very kindly gave me one of their old desktops and after talking with some other members I decided to install [Proxmox VE](https://www.proxmox.com/en/proxmox-ve) onto it.

# The setup

Proxmox wasn't very hard to setup, with some help from a Freesider that knew what they were doing we quickly set it up along with transferring over some OS images and setting up a few testing virtual machines.

A few weeks after that, after a flatmate donated a second NIC (the first one is used to connect to my laptop), I could connect the server to the internet and begin updating everything. The NIC took a while to setup but once working I've not had issues with it since. So now I could seriously begin the project. Over Christmas I received a [Unifi Switch](https://store.ui.com/collections/unifi-network-switching/products/usw-flex-mini) so it was time to set up the virtual machines for that along with [OPNsense](https://opnsense.org/), those two would handle the networking.

OPNsense was a bit of a pain to setup, with most of it being my fault and not noticing the proper isntall prompt, so every reboot would wipe all the configurtion. And annoyingly even when installed it would sometimes partially reset some of its config. The OPNsense box handles assigning IP addresses to devices connected to the server and switch as well as acting as a firewall.

The VM containing the Unifi software for running the switch was also a little bit of a pain to setup, as the version of Java it ships with doesn't actually work. In the end Java 8 worked (instead of a more up to date 17, another later version may work but I went with 8 as I've seen most people use that). However once tha Java issue was sorted I can't remember any issues with the switch so that's promising.

Along with networking, I decided to setup a [TrueNAS](https://www.truenas.com/) VM for storing backups from my laptop. This did not take long to setup and with some troubleshooting of the NFS share, I could begin backing up files from my laptop. Using a combination of `rsync` to transfer the data and `fdupes` for deduplication ([ZFS deduplication](https://www.truenas.com/docs/references/zfsdeduplication/) is very intensive, way outside of the scope of the current specs of the server). The whole process took around two days but at least now I have a backup of all my files should I need to restore them. I ordered another hard drive to act as a mirror, a [WD Red NAS](https://www.westerndigital.com/en-ie/products/internal-drives/wd-red-sata-hdd) drive.

I also plan to:

- set up a personal Git server using [Gitea](https://gitea.io/en-us/)
- set up [L2ARC](https://www.truenas.com/docs/references/l2arc/) for my NAS
- set up [FreeIPA](https://www.freeipa.org/page/Main_Page)
- set up various other [AAA](<https://en.wikipedia.org/wiki/AAA_(computer_security)>)
- set up [VLAN Tagging](https://documentation.meraki.com/General_Administration/Tools_and_Troubleshooting/Fundamentals_of_802.1Q_VLAN_Tagging)
- set up [Terraform](https://www.terraform.io/)

# Current issues

Sadly at present I am unable to continue working on the server as due to a somewhat unknown cause only 4GB out of the 24GB of RAM is displaying which prevents my VMs from starting. This may be an issue with the motherboard however I cannot be 100% sure until I open it up which will happen sometime in the future.
