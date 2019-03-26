#!/bin/bash

owner=${GITHUB_OWNER}
repo=${GITHUB_REPO}

repository_url=https://github.com/${owner}/${repo}
compare_branch=${COMPARE_BRANCH:-develop}
show_all_commit=${SHOW_ALL_COMMIT}

last_release_tag=$(git tag -l 'v*' --sort=-v:refname | head -1)
commits=$(git log --oneline --no-merges "${last_release_tag}..${compare_branch}")

IFS=$'\n'
stdin="\n"
for line in $(echo "${commits}"); do
  if [[ ! "${show_all_commit}" ]]; then
    [[ ${line} =~ \(#[0-9]+\)$ ]] && stdin+="- $line\n"
  else
    stdin+="- ${line}\n"
  fi
done

stdin+="\nCompare: ${repository_url}/compare/${last_release_tag}...${compare_branch}"

echo ${stdin}
