#!/usr/bin/env bash
# if [ "$1" != "-h" ] || [ "$1" != "--help" ]; then

title="$(echo "$1" | tr '[:upper:]' '[:lower:]')"
description=$2
date=$(date -u +%Y-%m-%d)

stripped_spaces=${title// /-}
filename="$(echo "$stripped_spaces" | tr '[:upper:]' '[:lower:]')".md

touch drafts/$filename
tee -a drafts/$filename <<EOF
---
title: $title
description: $description
date: $date
tags:
  - add-tags
layout: layouts/post.njk
---
EOF
exit 0
# fi

# display_help() {
#   echo "Usage: $0 [OPTION]... [ARGUMENTS]..."
#   echo "Create a new post"
#   echo
#   echo "Options:"
#   echo "  -h, --help    Display this help message and exit."
#   echo
#   echo "Arguments:"
#   echo "  Title   The title of the post, will also be formatted for the file name."
#   echo "  Description   The description of the post."
# }

Check if the -h or --help option is given
# if [ "$1" == "-h" ] || [ "$1" == "--help" ]; then
#   display_help
#   exit 0
# fi