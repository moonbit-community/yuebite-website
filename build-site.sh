#!/bin/sh
set -eu

mkdir -p _site
for locale in zh-CN en ja; do
  suffix="-$locale"
  locale_flag="--$locale"
  if [ "$locale" = zh-CN ]; then
    suffix=""
    locale_flag=""
  fi
  for page in index company contact ecosystem education competitions news; do
    set --
    if [ -n "$locale_flag" ]; then set -- "$locale_flag"; fi
    if [ "$page" != index ]; then set -- "$@" "--$page"; fi
    moon run . --target js --release -- "$@" > "_site/$page$suffix.html"
  done
done
cp site.css moonbit-logo.png moonbit-wordmark.png news-moonbit-downloads.jpg news-moonbit-meetup.jpg wechat-yuebite.png wechat-moonbit.png _site/
