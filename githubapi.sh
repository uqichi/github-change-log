#!/bin/bash

oauth_token=${GITHUB_OAUTH_TOKEN}
owner=${GITHUB_OWNER}
repo=${GITHUB_REPO}
endpoint=https://api.github.com/repos/${owner}/${repo}/releases

tag_name=${TAG_NAME}
target_branch=${TARGET_BRANCH:-master}
body=${BODY}

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

echo $data

curl -X POST \
  --data "${data}" \
  -H "Accept: application/vnd.github.v3+json" \
  -H "Authorization: token ${oauth_token}" \
  "${endpoint}"
