#!/bin/bash

slack_webhook_url=${SLACK_WEBHOOK_URL}

body=${BODY}

if [ -p /dev/stdin ]; then
    body=$(cat -)
fi

data=`cat << EOF
  payload={
    "attachments":[
      {
        "fallback":"Change log",
        "pretext":"Change log",
        "color":"#D00000",
        "fields":[
          {
            "title":"v1.0.0",
            "value":"${body}"
          }
        ]
      }
    ]
  }
EOF`

curl -X POST --data-urlencode "${data}" "${slack_webhook_url}"
