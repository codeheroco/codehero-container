#! /usr/bin/env bash

set -e

REMOTE_REPO=https://github.com/codeheroco/codehero-static.git
GIT_REPO=/home/codehero/codehero-repo
PUBLIC_WWW=/var/www/codehero-jekyll

BUNDLE="/usr/local/bin/bundle"

ISNEW=false

if [ ! -d "$GIT_REPO" ]; then
  echo "--------------> Cloning blog repo"
  git clone $REMOTE_REPO $GIT_REPO
  ISNEW=true
fi

LOCAL_REPO_HASH=$(git -C $GIT_REPO rev-parse @{0})
REMOTE_REPO_HASH=$(git -C $GIT_REPO rev-parse @{u})

if [ LOCAL_REPO_HASH != REMOTE_REPO_HASH ] || ISNEW ; then
  echo "--------------> Pulling changes latest changes..."
  git -C "$GIT_REPO" pull origin master

  echo "--------------> Starting to build the blog"
  echo "--------------> Installing dependencies if needed"
  $BUNDLE install --gemfile "$GIT_REPO"/Gemfile --deployment --without test --without development
  BUNDLE_GEMFILE="$GIT_REPO"/Gemfile $BUNDLE exec jekyll build --source $GIT_REPO --destination $PUBLIC_WWW
  echo "--------------> Application Deployed to $PUBLIC_WWW"
else
  echo "--------------> Blog is up to date, doesn't need regeneration"
fi
