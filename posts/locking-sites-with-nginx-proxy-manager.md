---
title: Locking sites with Nginx Proxy Manager
description: How to lock your sites that don't have built in authentication
date: 2022-06-09
tags:
  - Nginx
  - self-hsting
  - how-to
layout: layouts/post.njk
---

I was looking for a way to lock my sites that need some sort of authentication that does not come built in. I had tried [Autheila](https://github.com/authelia/authelia) but I could never get it working. So here is a quick tutorial on locking sites with [Nginx Proxy Manager](https://nginxproxymanager.com/) (NPM)
First of all, I'm going to assume you have some sites that are *already* proxied via NPM. If you don't have any sites proxied then you can folloew [this guide](https://docs.kieranrobson.com/posts/how-to-setup-nginx-proxy-manager-and-cloudflare-copy/) by Kieran Robson.  
Once you have a site proxied go to your Access Lists, click on Add Access List and give it a name. Under Authorization enter in a username and password you want to lock a site with. Then in Access type all in allow, or if you have a specific IP range you want to be able to connect from, you can enter it here. Leave deny on all then press Save.  
Navigate back to Hosts > Proxy Hosts and edit (triple dot icon) the site you want to lock then click on Access List and change from Publicly Accessible to the name of the Access List you chose. Click save and then navigate to the URL of the site. You should no be prompted with a login prompt and be met with a 401 error if you enter incorrect details.
