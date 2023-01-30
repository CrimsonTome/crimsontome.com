---
title: On switching to nginx properly
description: Switching from Nginx Proxy Manager to Nginx
date: 2023-01-30
tags:
  - Nginx
  - self-hosting
layout: layouts/post.njk
---

![](https://upload.wikimedia.org/wikipedia/commons/c/c5/Nginx_logo.svg)

<br>

Recently, I switched from [Nginx Proxy Manager](https://github.com/NginxProxyManager/nginx-proxy-manager) - the Docker container - to bare [Nginx](https://www.nginx.com/). Or more specifically the open source webserver and reverse proxy - there are many other [products](https://www.nginx.com/products/) available. There were a few reasons for this:

- Nginx Proxy Manager could be quite memory heavy, causing my VPS to slow down at times
- Some weird certificate errors I had no idea how to solve caused Nginx Proxy Manager to break a few times
- I wanted to learn how to configure Nginx from the ground up - rather than playing with predefined blocks that could be overwrote if I didn't do it right - and I would have to learn it anyway for where I hope to do my year in industry so why not get started early
- I had friends recommend it to me that have knowledge of Nginx and certificate management so I knew I would have people to go to should I need help

Getting started, I shut down my Nginx Proxy Manager container and was ready for a little downtime but this would not have been too much of an issue as I don't run any _critical_ services, all I was really worried about was my password manager and GitHub --> [Gitea](https://github.com/go-gitea/gitea/) backups managed by [this](https://github.com/jaedle/mirror-to-gitea), which mirrors public repos to my [Gitea instance](https://git.crimsontome.com). Sadly this tool does not yet have the ability to mirror private repositories - see [this pull request](https://github.com/jaedle/mirror-to-gitea/pull/4), but with risk of going too off topic, I'll leave anymore talk of this for a future post.

With the container teared down, I installed Nginx with

```sh
sudo nala install nginx
```

([nala](https://github.com/volitank/nala) is a wrapper around apt) and made sure it was enabled and running with

```txt
ctome in 🌐 crimsontome in ~
> sudo systemctl status nginx
[sudo] password for ctome:
● nginx.service - A high performance web server and a reverse proxy server
     Loaded: loaded (/lib/systemd/system/nginx.service; enabled; vendor preset: enabled)
     Active: active (running) since Sat 2023-01-28 09:42:22 UTC; 1 day 17h ago
       Docs: man:nginx(8)
    Process: 819 ExecStartPre=/usr/sbin/nginx -t -q -g daemon on; master_process on; (code=exited, status=0/SUCCESS)
    Process: 1001 ExecStart=/usr/sbin/nginx -g daemon on; master_process on; (code=exited, status=0/SUCCESS)
    Process: 170432 ExecReload=/usr/sbin/nginx -g daemon on; master_process on; -s reload (code=exited, status=0/SUCCESS)
   Main PID: 1153 (nginx)
      Tasks: 3 (limit: 4546)
     Memory: 12.9M
        CPU: 2min 46.861s
     CGroup: /system.slice/nginx.service
             ├─  1153 "nginx: master process /usr/sbin/nginx -g daemon on; master_process on;"
             ├─170461 "nginx: worker process" "" "" "" "" "" "" "" "" "" "" "" "" "" "" "" "" "" "" "" "" "" "" "" "" "" "" ""
             └─170462 "nginx: worker process" "" "" "" "" "" "" "" "" "" "" "" "" "" "" "" "" "" "" "" "" "" "" "" "" "" "" ""

Jan 28 09:42:20 crimsontome.com systemd[1]: Starting A high performance web server and a reverse proxy server...
Jan 28 09:42:22 crimsontome.com systemd[1]: Started A high performance web server and a reverse proxy server.
Jan 28 09:53:34 crimsontome.com systemd[1]: Reloading A high performance web server and a reverse proxy server...
Jan 28 09:53:34 crimsontome.com systemd[1]: Reloaded A high performance web server and a reverse proxy server.
Jan 28 10:37:19 crimsontome.com systemd[1]: Reloading A high performance web server and a reverse proxy server...
Jan 28 10:37:19 crimsontome.com systemd[1]: Reloaded A high performance web server and a reverse proxy server.

```

Once I knew the service was running correctly, I had to verify that the default page was working by going to the root of my domain (http://crimsontome.com) and as expected the page was waiting for me, telling me Nginx was working. Next was to move it from `/etc/nginx/sites-enabed/default` to `/etc/nginx/sites-available/default`

Next was adding the following to my config at `/etc/nginx/nginx.conf` within the `http` block and replacing 'port-number' with the corresponding port for that service

```nginx
http {
	# ... default config...
	upstream service {
		server 127.0.0.1:port-number;
	}
	# repeating upstreams for all services
}

# ... more config ...
```

Upstream is nice for handling services that don't have a defined source like `/var/www/site`. Since I run most of my sites inside Docker containers and expose the ports this is quite handy.

Next was adding individual site configuration, for example my main page at `/etc/nginx/sites-enabled/crimsontome.com.conf`:

```nginx
server {
    listen 80
    server_name crimsontome.com;
    location / {
        proxy_pass http://root;
    }
}
```

This all seemed pretty simple and after restarting Nginx with

```sh
sudo nginx -s reload
```

all seemed to work when visiting http://service.crimsonmtome.com (don't try the link it's not a real one, at least I hope it doesn't exist 😛). This wasn't as hard as I originally thought this would be, until I encountered certificates for managing HTTPS connections. . .

It started off with Certbot and its Nginx plugin, allowing HTTPS with Nginx and disabling HTTP. All HTTP traffic is redirected to HTTPS anyway

```sh
sudo nala install certbot python3-certbot-nginx
sudo ufw allow 'Nginx Full'
sudo ufw delete allow 'Nginx HTTP'
sudo ufw status
```

then to give each site it's certificate

```txt
xargs -L1 sudo certbot --nginx --expand  -d < ~/domains
```

where domains is a newline separated list of domains

Later I was told to use `certonly` with the `certbot` command, at which point I tried that but was met with being rate limited by Let's Encrypt. Fun.

After waiting a while longer I tried again but encountered errors again, certificates already existing etc, more rate limiting. It was pointed out to me later on thatI should have used the staging server to test all of this before I was sure.

I purged Certbot and removed mentions of it in my Nginx configs then re installed and tried re creating the certificates, but then Nginx complained because Certbot didn't put the certificate fields back. At this point I was about to give up until a [friend](https://github.com/lgibson02) - the follwing snippets are from him - suggested [acme-tiny](https://github.com/diafygi/acme-tiny) - installed with

```sh
sudo apt-get install acme-tiny
```

and creating a new script at `usr/local/bin/update-cert`

```sh
#!/bin/sh
set -e
echo "$0 | $(date)"
[ -z "$1" ] && echo "Usage: $(basename $0) <domains...>" && exit 1
domains="$@"

set_permissions() {
    chown root:$2 "$1/"*
    chmod 0640 "$1/"*
}

check_current_cert() {
    rm -rf /tmp/cert
    mkdir -p /etc/cert
    cp -rf /etc/cert /tmp
    cd /tmp/cert
    # check type of current certificate is the same as the type to be updated to
    [ -f type ] && [ "$(cat type)" = "$1" ] && return 0
    # if type doesnt match...
    rm -rf ./* # clear directory
    echo "$1" > type # write new type
}

make_signing_request() {
    subject_alt_name="DNS:$(echo "$domains" | sed "s/ /, DNS:/g")"
    openssl req -nodes -newkey rsa:4096 -keyout private.key -subj "/" \
        -addext "subjectAltName = $subject_alt_name" > "$1"
}

install() {
    cp -rf ./* /etc/cert
    set_permissions /etc/cert root
    systemctl reload-or-restart nginx
}

install_self_signed() {
    check_current_cert selfsigned
    make_signing_request request.csr
    openssl x509 -in request.csr -req -signkey private.key > certificate.crt
    install
}

install_letsencrypt_signed() {
    check_current_cert letsencrypt
    make_signing_request request.csr
    test -f account.key || openssl genrsa 4096 > account.key
    set_permissions . www-data
    sudo -u www-data acme-tiny --account-key account.key --csr request.csr \
        --acme-dir /var/www/acme-challenge/ > ./certificate.crt
    rm -rf /var/www/acme-challenge/*;
    install
}

echo "Updating certificate..."
# NGINX is needed for the ACME challenge to complete but it will not start
# without a certificate, so begin with a self-signed one.
if [ ! -d /etc/cert ]; then
    install_self_signed
fi
install_letsencrypt_signed
```

Adding this to `/etc/nginx/snippets/listen-https.conf`

```nginx
listen 443 http2 ssl;
listen [::]:443 http2 ssl;
add_header Strict-Transport-Security "max-age=31536000" always;
ssl_certificate /etc/cert/certificate.crt;
ssl_certificate_key /etc/cert/private.key;
```

and this to the default Nginx http block

```nginx
# plaintext HTTP server:
#   1) sends redirect to HTTPS servers
#   2) serves ACME challenge for renewing SSL certificate
server {
    listen 80 default;
    listen [::]:80 default;

    location / {
        return 301 https://$host$request_uri;
    }

    location /.well-known/acme-challenge/ {
        alias /var/www/acme-challenge/;
        try_files $uri /;
    }
}
```

Creating a directory owned by `www-data` at `/vaw/www/acme-challenge`

```sh
sudo mkdir /var/www/acme-challenge
sudo chown -R www-data:www-data /var/www/acme-challenge
```

After testing with the staging server I thought that the following would work with `update-cert`

```sh
sudo xargs -L1 update-cert < ~/domains
```

However this would make all my certificates be the last one in the list. Removing `-L1` fixed the problem once I was - one more time - no longer rate limited.

Finally, setting up the cron job to auto renew certs with:

```sh
sudo crontab -e
```

adding the following

```txt
42 7 1 * * xargs update-cert < /home/ctome/domains 2>&1 > /var/log/cert.log
```

From then on, all my sites had working TLS.
