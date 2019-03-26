#!/bin/bash

slack_webhook_url=${SLACK_WEBHOOK_URL}

if [[ -p /dev/stdin ]]; then
    cat -
else
    echo $@
fi

exit

value=$1

data=`cat << EOF
  payload={
    "attachments":[
      {
        "fallback":"fallback Test",
        "pretext":"attachments Test",
        "color":"#D00000",
        "fields":[
          {
            "title":"attachment01",
            "value":"${value}"
          }
        ]
      }
    ]
  }
EOF`

curl -X POST --data-urlencode "${data}" "${slack_webhook_url}"
