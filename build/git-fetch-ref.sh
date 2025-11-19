#!/bin/sh

# Description : this script is used to clone a repo and set the HEAD to either : a branch, a tag or a commit hash. 
# This script rely on environment variables such as GIT_REPO, GIT_REF and REPO_NAME. 
# Its intendent to be used inside of a docker container but it can also be used outside.
# Author : Clément de la Genière, 2025
set -eu

fetch_branch() {
	git clone --depth 1 --branch "$GIT_REF" "$GIT_REPO" "$REPO_NAME"
}

fetch_tag() {
	git clone --depth 1 "$GIT_REPO" "$REPO_NAME"
	cd "$REPO_NAME"
	git fetch --depth 1 origin "refs/tags/$GIT_REF:refs/tags/$GIT_REF"
	git checkout "$GIT_REF"
}

fetch_commit() {
	git clone --depth 1 "$GIT_REPO" "$REPO_NAME"
	cd "$REPO_NAME"
	git fetch --depth 1 origin "$GIT_REF"
	git checkout "$GIT_REF"
}

command -v git
echo "Repo : $GIT_REPO"
echo "Ref : $GIT_REF"
echo "Ref type : $REF_TYPE"
echo "Repo name : $REPO_NAME"

case "$REF_TYPE" in
	"branch") fetch_branch ;;
	"commit") fetch_commit ;;
	"tag") fetch_tag ;;
	*)
		echo "Unknown ref type: $REF_TYPE" >&2
		exit 1
		;;
esac
