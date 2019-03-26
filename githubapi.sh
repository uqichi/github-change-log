#!/bin/bash

owner=${GITHUB_OWNER}
repo=${GITHUB_REPO}
oauth_token=${GITHUB_OAUTH_TOKEN}
endpoint=https://api.github.com/repos/${owner}/${repo}/releases

tag_name=${TAG_NAME}
target_branch=${TARGET_BRANCH:-master}
body=${BODY}

if [ -p /dev/stdin ]; then
    body=$(cat -)
fi

data=`cat << EOF
{
  "tag_name": "${tag_name}",
  "target_commitish": "${target_branch}",
  "name": "${tag_name}",
  "body": "${body}",
  "draft": false,
  "prerelease": false
}
EOF`


curl -X POST \
  --data "${data}" \
  -H "Accept: application/vnd.github.v3+json" \
  -H "Authorization: token ${oauth_token}" \
  "${endpoint}"
