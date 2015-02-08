#! /usr/bin/env bash

set -e

REMOTE_REPO=https://github.com/codeheroco/codehero-static.git
GIT_REPO=/home/codehero/codehero-repo
PUBLIC_WWW=/var/www/codehero-jekyll

BUNDLE="/usr/local/bin/bundle"

if [ ! -d "$GIT_REPO" ]; then
  echo "--------------> Cloning blog repo"
  git clone $REMOTE_REPO $GIT_REPO
fi

echo "--------------> Pulling changes latest changes..."
git -C "$GIT_REPO" pull origin master

# Check if any file has changed, if so rebuild the blog
NEW_HASH=$(ls -laR $GIT_REPO | md5sum)

if [ "$NEW_HASH" != "$REPO_HASH" ]; then
  echo "--------------> Starting to build the blog"
  echo "--------------> Installing dependencies if needed"
  $BUNDLE install --gemfile "$GIT_REPO"/Gemfile --deployment --without test --without development &&\
  LC_ALL=en_US.UTF-8 $BUNDLE exec jekyll build --source $GIT_REPO --destination $PUBLIC_WWW &&\
  echo "--------------> Application Deployed to $PUBLIC_WWW" &&\
  TZ='America/Caracas' date

  export REPO_HASH="$NEW_HASH"
else
  echo "--------------> Blog is up to date, doesn't need regeneration"
fi
