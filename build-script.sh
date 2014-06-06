#! /usr/bin/env bash

set -e

GIT_REPO=/home/codehero/codehero-repo.git
VENDOR=/home/codehero
TMP_GIT_CLONE=/home/codehero/tmp/repo
PUBLIC_WWW=/var/www/codehero-jekyll
BUILD_LOG=/home/codehero/build.log

BUNDLE="/usr/local/bin/bundle"

cd $TMP_GIT_CLONE &&\
  echo "--------------> Starting to build the blog" &&\
  echo "--------------> Installing dependencies if needed" &&\
  $BUNDLE install --path $VENDOR/vendor --deployment --without test --without development &&\
  LC_ALL=en_US.UTF-8 $BUNDLE exec jekyll build --source $TMP_GIT_CLONE --destination $PUBLIC_WWW &&\
echo "--------------> Application Deployed to $PUBLIC_WWW" &&\
TZ='America/Caracas' date

