#!/bin/bash

slack_webhook_url=${SLACK_WEBHOOK_URL}

env=${ENV}
title=${TITLE:-notitle}
value=${VALUE:-novalue}

if [ -p /dev/stdin ]; then
    value=$(cat -)
fi

case "${env}" in
  "dev" | "develop" ) env=Dev; color=#00adb9 ;;
  "stg" | "staging" ) env=Stg; color=#f7ea00 ;;
  "prd" | "production" ) env=Prd; color=#ff188a ;;
esac

data=`cat << EOF
payload={
  "attachments":[
    {
      "fallback":"[${env}] Change log",
      "pretext":"*_[${env}]_* Change log",
      "color":"${color}",
      "fields":[
        {
          "title":"${title}",
          "value":"${value}"
        }
      ]
    }
  ]
}
EOF`


curl -X POST \
  --data-urlencode "${data}" \
  "${slack_webhook_url}"
