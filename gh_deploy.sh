#!/usr/bin/env bash

SOURCE_COMMIT="$(git log -1 --pretty="%an: %B" "$GITHUB_SHA")"
[[ $JEKYLL_SITE_DEST ]] && dest_dir="${JEKYLL_SITE_DEST}" || dest_dir="${JEKYLL_SITE_SRC}/_site"
pushd $dest_dir &>/dev/null
: > .nojekyll

git add --all
git -c user.name="${GITHUB_ACTOR}" -c user.email="${GITHUB_ACTOR}@users.noreply.github.com" \
  commit --quiet \
         --message "Deploy site from ${GITHUB_SHA}" \
         --message "$SOURCE_COMMIT"
git push

popd &>/dev/null
