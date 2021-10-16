---
title:  Making your own blog
description: Second post, how to make your own blog using GitHub, Netlify and Eleventy.
date: 2021-10-16
tags:
  - second post
  - github
  - netlify
  - web development
layout: layouts/post.njk
---


Please note that I will be updating this as I go along. This is my **first** time using Netlify, as such I lack a lot of experience using the service so far. I have been using GitHub consistently since September 2021 so I am still relatively new to how everything works. If there are any issues you can log them [here](https://github.com/CrimsonTome/crimsontome-blog/issues), ping me on Discord: CrimsonTome427#7459 or send me and email at crimsontome427@gmail.com

## Still here?

Please note that this guide assumes you're working in a browser rather than a terminal/command line.  

Well, let's begin.

First of all, if you want to use GitHub as the source for your code you'll need a repository(repo). If you're reading this then you may be new to GitHub like I was not so long ago.  

### Creating the repo

You can either create your own from scratch and setup a framework later

- Go to <https://github.com/new>
- Under `Repository name` enter what you want the repo to be called e.g. my-blog
- Under `Description` you can add a bit about your site, for example what it is about and how it is made
- Make sure `Public` is ticked, it should be by default
- You can tick `Add a README file` to go into more detail about your code if you wish. It is not completely necessary but may be useful for explaining your repo to other users or those that are interested but don't understand what exactly is going on by viewing the code itself
- Click `Create repository`

**OR**

You can create your repo using a template (what I did) e.g Eleventy's base template

- Go to <https://github.com/11ty/eleventy-base-blog/generate>
- Under `Repository name` enter what you want the repo to be called e.g. my-blog
- Under `Description` you can add a bit about your site, for example what it is about and how it is made
- Make sure `Public` is ticked, it should be by default
- Keep `Include all branches` unticked (it's what I did, so some things may be different if you decide to tick it, I can't help with some things at that point)

GitHub will then generate your repo using the eleventy base blog template. There will be a list of files generated, an important one being `README.md`. As the README states, you will need to `Edit _data/metadata.json`. You will find this at `https://github.com/your-github-name/your-repo-name/blob/master/_data/metadata.json`. But first, make sure you commit your changes if you've made any and let's head over to [Netlify](https://app.netlify.com/signup).  
You can use your email or GitHub login (I'd recommend using GH as that is what I did). Once logged in go to <https://app.netlify.com/start>, choose `GitHub` as the option for Continuous Deployment then select your repo you have created with the elventy template. Then click `Deploy site`. Head to `https://app.netlify.com/sites/user-name/settings/general#site-details`. For now Netlify provides you with its own subdomain at `subdomain.netlify.app` but you can change it by presssing `Change site name`.  
Back to GitHub, remember `metadata.json`? You'll need to fill that in now to customise the template to match you.
```
{
  "title": "Blog title",
  "url": "https://subdomain-you-chose.netlify.app/",
  "language": "en",
  "description": "add a description here",
  "feed": {
    "subtitle": "add a subtitle here",
    "filename": "feed.xml",
    "path": "/feed/feed.xml",
    "id": "https://subdomain-you-chose.netlify.app/"
  },
  "jsonfeed": {
    "path": "/feed/feed.json",
    "url": "https://subdomain-you-chose.netlify.app/feed/feed.json"
  },
  "author": {
    "name": "your-name",
    "email": "your-email,
    "url": "hhtps://subdomain-you-chose.netlify.app/about-me/"
  }
}
```  

Make sure to commit your changes and then netlify should automatically rebuild your site. It shouldn't take more than a minute to do so.  
You can add an about me page by editing `/about/index.md`. Leave the front matter (stuff surrounded by):
```
---

---
```
Now then, you'll probably want to make some blog posts, this is a blog repo that you're maiking after all right?   
The Eleventy base blog template comes with a few in `/posts`, I'd recommend leaving the layout section in the front matter, change everything else as you please. Oh and you can rename the file, just keep at as `something.`**md**
