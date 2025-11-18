#!/bin/sh

# debug start
_GIT_REPO="https://github.com/neovim/neovim.git"
_REF_TYPE="commit"
# _REF="release-0.10" # branch
# _REF="stable" # tag
_REF="18e6ba90e25327dd8b34960902f3433cf00259dc" # commit

echo "ref type : $_REF_TYPE"

# debug end
set -eu

command -v git
echo "Repo : $_GIT_REPO"
echo "Ref : $_REF"
repo_name="$(basename "$_GIT_REPO")"

git clone --depth 1 "$_GIT_REPO" "$repo_name"
cd "$repo_name"

case "$_REF_TYPE" in
	"branch")
		git fetch --depth 1 origin "$_REF"
		git checkout -b "$_REF" FETCH_HEAD
		;;
	"commit")
		git fetch --depth 1 origin "$_REF"
		git checkout "$_REF"
		;;
	"tag") 
        git fetch --depth 1 origin "refs/tags/$_REF:refs/tags/$_REF"
        git checkout "$_REF"
		;;
	*)
		echo "Unknown ref type: $_REF_TYPE" >&2
		exit 1
		;;
esac
