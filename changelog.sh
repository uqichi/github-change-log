#!/bin/bash

owner=${GITHUB_OWNER}
repo=${GITHUB_REPO}

repository_url=https://github.com/${owner}/${repo}
compare_branch=${COMPARE_BRANCH:-develop}

local stdin="\n"

LAST_RELEASE_TAG=$(git tag -l 'v*' --sort=-v:refname | head -1)

RELEASE_LIST=$(git log --oneline --no-merges "${LAST_RELEASE_TAG}..${compare_branch}")

IFS=$'\n'
for line in $(echo "${RELEASE_LIST}"); do
    #[[ ${line} =~ \(#[0-9]+\)$ ]] && echo "- $line"
    stdin+="- ${line}\n"
done

stdin+="\nCompare: ${repository_url}/compare/${LAST_RELEASE_TAG}...${compare_branch}"

echo ${stdin}
