#!/bin/bash

#${BRANCH}
#${COMPARE_URL}
#${PROJ_REPO}
#${PROJ_USER}

repository_url=https://github.com/uqichi/github-change-log
compare_branch=develop

echo "## Changes"

LAST_RELEASE_TAG=$(git tag -l 'v*' --sort=-v:refname | head -1)

RELEASE_LIST=$(git log --oneline --no-merges "${LAST_RELEASE_TAG}..${compare_branch}")

IFS=$'\n'
for line in $(echo "$RELEASE_LIST"); do
    [[ ${line} =~ \(#[0-9]+\)$ ]] && echo "- $line"
done

echo "\nDiff: ${repository_url}/compare/${LAST_RELEASE_TAG}...${compare_branch}"

