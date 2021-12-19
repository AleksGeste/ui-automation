#!/usr/bin/env bash

# Read input variables
COMPONENT=$1
STATUS=$2

echo $STATUS

# Default message
MESSAGE=""$COMPONENT" failed :no_entry:"
if [ $STATUS = 0 ]; then
    MESSAGE=""$COMPONENT" passed :white_check_mark:"
fi

# Send notification
curl -X POST \
  https://discord.com/api/webhooks/921934267976663051/O2iAAxirYAZBLO7WWoq7uNrbMhtG94MAiyZhaM7Z-BrNVxEzRvLjahjT-OZsq2QC8Ffh \
  -H 'Cache-Control: no-cache' \
  -H 'Content-Type: application/json' \
  -d '{
	"content":"'"$MESSAGE"'"
}'
